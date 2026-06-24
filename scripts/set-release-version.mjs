import fs from "node:fs";

const version = process.argv[2];

if (!version) {
  console.error("Usage: node scripts/set-release-version.mjs <version>");
  process.exit(1);
}

function updateJson(path, mutator) {
  const data = JSON.parse(fs.readFileSync(path, "utf8"));
  mutator(data);
  fs.writeFileSync(path, `${JSON.stringify(data, null, 2)}\n`);
}

function replace(path, pattern, value) {
  const before = fs.readFileSync(path, "utf8");
  const after = before.replace(pattern, value);
  if (after === before) {
    throw new Error(`No version replacement matched in ${path}`);
  }
  fs.writeFileSync(path, after);
}

function updateOpenApiVersion(path) {
  const before = fs.readFileSync(path, "utf8");

  if (before.trimStart().startsWith("{")) {
    const data = JSON.parse(before);
    data.info ??= {};
    data.info.version = version;
    const formatted = before.includes("\n")
      ? `${JSON.stringify(data, null, 2)}\n`
      : JSON.stringify(data);
    fs.writeFileSync(path, formatted);
    return;
  }

  const eol = before.includes("\r\n") ? "\r\n" : "\n";
  const lines = before.split(/\r?\n/);
  const infoIndex = lines.findIndex((line) => /^info:\s*(?:#.*)?$/.test(line));

  if (infoIndex === -1) {
    throw new Error(`No OpenAPI info block found in ${path}`);
  }

  let endIndex = lines.length;
  for (let index = infoIndex + 1; index < lines.length; index += 1) {
    if (/^\S/.test(lines[index])) {
      endIndex = index;
      break;
    }
  }

  for (let index = infoIndex + 1; index < endIndex; index += 1) {
    if (/^\s+version\s*:/.test(lines[index])) {
      const indent = lines[index].match(/^\s*/)[0];
      lines[index] = `${indent}version: ${version}`;
      fs.writeFileSync(path, lines.join(eol));
      return;
    }
  }

  lines.splice(infoIndex + 1, 0, `  version: ${version}`);
  fs.writeFileSync(path, lines.join(eol));
}

updateJson("package.json", (data) => {
  data.version = version;
});

updateJson("sdks/typescript/package.json", (data) => {
  data.version = version;
});

replace("sdks/python/pyproject.toml", /^version = ".*"$/m, `version = "${version}"`);
replace("sdks/java/pom.xml", /(<groupId>ai\.agora<\/groupId>\s*\n\s*<artifactId>agora-public-api<\/artifactId>[\s\S]*?<version>)[^<]+(<\/version>)/, `$1${version}$2`);
updateOpenApiVersion("openapi/agora-public-api.yaml");

console.log(`Set SDK release version to ${version}`);
