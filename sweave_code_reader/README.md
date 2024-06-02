# Sweave Code Reader Example

## How to Use

- Abhi's script: 

```bash
cd ./sweave_code_reader
pandoc 008-outdec.Rnw --from latex -f sweave_code_reader_Abhi.lua -t markdown -o file.md
```

- phinney's original script: 

```bash
cd ./sweave_code_reader
pandoc 008-outdec.Rnw --from latex -f sweave_code_reader.lua --lua-filter code_chunk_patch.lua -t markdown-simple_tables-pipe_tables-fenced_code_attributes -o file.md
```

- phinney's script to capturing the non code block parts of the document: 

```bash
cd ./sweave_code_reader
pandoc 008-outdec.Rnw --from latex -f sweave_code_reader.lua --lua-filter code_chunk_patch.lua -t markdown-simple_tables-pipe_tables-fenced_code_attributes -o file.md
pandoc 008-outdec.Rnw --from latex -f Sweave_code_remove.lua -t latex -o file.tex
```