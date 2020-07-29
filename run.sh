
#!/bin/bash

rm *.so *.c *.html
rm -r build/
python setup.py build_ext --inplace
echo
echo "Setup Finished"
echo
python main.py
