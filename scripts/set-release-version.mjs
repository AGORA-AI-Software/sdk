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

updateJson("package.json", (data) => {
  data.version = version;
});

updateJson("sdks/typescript/package.json", (data) => {
  data.version = version;
});

replace("sdks/python/pyproject.toml", /^version = ".*"$/m, `version = "${version}"`);
replace("sdks/java/pom.xml", /<artifactId>agora-public-api<\/artifactId>\s*\n\s*<version>[^<]+<\/version>/, `<artifactId>agora-public-api</artifactId>\n  <version>${version}</version>`);
replace("openapi/agora-public-api.yaml", /^  version: .*$/m, `  version: ${version}`);

console.log(`Set SDK release version to ${version}`);
