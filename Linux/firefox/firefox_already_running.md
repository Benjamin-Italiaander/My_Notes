# firefox already running 


If you try to open firefox and get the message firefox already running,
you may try this script


```bash
#!/bin/bash
files=`find ~/.mozilla -name "*lock"`
for file in `echo $files`
do
  echo "removing $file..."
  rm "$file"
done
```
