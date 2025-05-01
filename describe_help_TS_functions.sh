#!/bin/bash
echo '''
<html>
<head>
<style>
body {
    color: #000000;
    background-color: #dddddd;
}
h3, p {margin: 0.2rem}
p.function_name {
    font-size: 1.05rem;
    font-style: italic;
}
.function_help {
    color: #000;
    background-color: #fff;
}
</style>
</head>
<body>
<h1 style="text-align: center;">HELP LIST : TS-functions </h1>
<p> Source code: <a href="https://github.com/Leo-TakumaSugashi/TS-functions">TS-functions/GitHub</a></p>
<hr>
''' > help.html

find . -name "*.m" | sort | while read -r f; do
    echo $f
    python MATLAB_function_help_extraction.py $f >> help.html
done

echo -e "</body>\n</html>" >> help.html