# Sweave Code Reader Example

## How to Use

```bash
cd ./sweave_code_reader
pandoc 008-outdec.Rnw --from latex -f sweave_code_reader_Abhi.lua -t markdown -o file.md
pandoc 008-outdec.Rnw --from latex -f sweave_code_reader.lua --lua-filter code_chunk_patch.lua -t markdown-simple_tables-pipe_tables-fenced_code_attributes -o file.md
```