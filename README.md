# Snowflake ID Module for Roblox
Module to create realtively short and unique ID's for your proejcts in Roblox!

### Functions
| Function           | Params                   | Description                                                              |
| ---                | ---                      | ---                                                                      |
| `new`              | *None*                   | Generates random ID                                                      |
| `AddPrefix`        | ID: SnowflakeID          | Adds string before or after the id                                       |
|                    | Prefix: string           |                                                                          |
|                    | before: boolean?         |                                                                          |
| `ConvertIntoChars` | ID: SnowflakeID          | Converts given Snowflake ID into characters corresponding Utf-8 encoding |
|                    | SliceEveryXStep: number? |                                                                          |

### Types
| Type           | Properties        |
| ---            | ---               |
| `SnowflakeID`  | ID: string        |
|                | Timestamp: number |
