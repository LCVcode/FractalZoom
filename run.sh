
#!/bin/bash

cd lib/
rm *.so *.c
rm -r build/
python setup.py build_ext --inplace
cd ..
echo
echo "Setup Finished"
echo
python main.py
