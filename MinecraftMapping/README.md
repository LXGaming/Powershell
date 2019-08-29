# Powershell - Minecraft Mapping
Convert MCP class mappings contained in tsrg & srg files to json.

Convert Notch mappings outputted by [Burger](https://github.com/mcdevs/Burger) to MCP mappings.

## Usage
### Convert MCP Mappings
- Download MCP_Config from https://files.minecraftforge.net/maven/de/oceanlabs/mcp/mcp_config/
- Extract `joined.tsrg` file
- Run `mcp_mapper.ps1 joined.tsrg mapping.json`
### Extracting Minecraft Data

```
git clone https://github.com/mcdevs/Burger.git
cd Burger
python3 setup.py install
python3 munch.py --download <VERSION> --output <VERSION>.json
```
### Converting Burger Output
```
burger_mapper.ps1 <VERSION>.json mapping.json output.json
```
