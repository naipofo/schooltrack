import { PgSimplifyInflectionPreset } from "@graphile/simplify-inflection";
import { makePgService } from "postgraphile/adaptors/pg";
import { PostGraphileAmberPreset } from "postgraphile/presets/amber";
import { PgLazyJWTPreset } from "postgraphile/presets/lazy-jwt";

const jwtKey = "keyboard_kitten"; // TODO: from env

/** @type {GraphileConfig.Preset} */
const preset = {
  extends: [
    PgSimplifyInflectionPreset,
    PostGraphileAmberPreset,
    PgLazyJWTPreset,
  ],
  pgServices: [
    makePgService({
      connectionString:
        "postgres://postgres:trackpassword@localhost:5432/trackdb",
      schemas: ["app_public"],
    }),
  ],
  grafserv: {
    watch: true,
    port: 42239,
    websockets: true
  },
  schema: {
    pgJwtSecret: jwtKey,
    exportSchemaSDLPath: "../flutter_school_track/lib/gql/requests/schema.graphql"
  }
};

export default preset;
