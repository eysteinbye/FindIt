# How to install coremltools


From the [coremlutils guide](https://pypi.python.org/pypi/coremltools) we are told to use `pip` to install.
```
pip install -U coremltools
```

On my Mac with Python 2.7.10 I then get this:
```
Collecting coremltools
  Using cached coremltools-0.3.0-py2.7-none-any.whl
Collecting numpy>=1.6.2 (from coremltools)
  Using cached numpy-1.13.0-cp27-cp27m-macosx_10_6_intel.macosx_10_9_intel.macosx_10_9_x86_64.macosx_10_10_intel.macosx_10_10_x86_64.whl
Collecting protobuf>=3.1.0 (from coremltools)
Collecting six>=1.9 (from protobuf>=3.1.0->coremltools)
  Using cached six-1.10.0-py2.py3-none-any.whl
Collecting setuptools (from protobuf>=3.1.0->coremltools)
  Using cached setuptools-36.0.1-py2.py3-none-any.whl
Installing collected packages: numpy, six, setuptools, protobuf, coremltools
  Found existing installation: numpy 1.8.0rc1
    DEPRECATION: Uninstalling a distutils installed project (numpy) has been deprecated and will be removed in a future version. This is due to the fact that uninstalling a distutils project will only partially uninstall the project.
    Uninstalling numpy-1.8.0rc1:
Exception:
Traceback (most recent call last):
  File "/Library/Python/2.7/site-packages/pip-9.0.1-py2.7.egg/pip/basecommand.py", line 215, in main
    status = self.run(options, args)
  File "/Library/Python/2.7/site-packages/pip-9.0.1-py2.7.egg/pip/commands/install.py", line 342, in run
    prefix=options.prefix_path,
  File "/Library/Python/2.7/site-packages/pip-9.0.1-py2.7.egg/pip/req/req_set.py", line 778, in install
    requirement.uninstall(auto_confirm=True)
  File "/Library/Python/2.7/site-packages/pip-9.0.1-py2.7.egg/pip/req/req_install.py", line 754, in uninstall
    paths_to_remove.remove(auto_confirm)
  File "/Library/Python/2.7/site-packages/pip-9.0.1-py2.7.egg/pip/req/req_uninstall.py", line 115, in remove
    renames(path, new_path)
  File "/Library/Python/2.7/site-packages/pip-9.0.1-py2.7.egg/pip/utils/__init__.py", line 267, in renames
    shutil.move(old, new)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/shutil.py", line 302, in move
    copy2(src, real_dst)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/shutil.py", line 131, in copy2
    copystat(src, dst)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/python2.7/shutil.py", line 103, in copystat
    os.chflags(dst, st.st_flags)
OSError: [Errno 1] Operation not permitted: '/var/folders/dv/_7nssh7j4qq93wkmqt27tlmw0000gn/T/pip-xCQA31-uninstall/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy-1.8.0rc1-py2.7.egg-info'
```

I then thought it would be smart to make a Docker container with a clean Python image for the conversion, but that resulted in this error:

```
RuntimeError: Caffe conversion is only supported on macOS.
```

I then decided to use (virtualenv)[https://virtualenv.pypa.io/en/stable/]
```
sudo pip install virtualenv
virtualenv coreml
source coreml/bin/activate
```

Prompt will change to `(coreml) ~` and you can now install `coremlutils` in a clean environment.
```
pip install -U coremltools
```
 
The conversion was a simpel Python script. like this:
```
import coremltools
coreml_model = coremltools.converters.caffe.convert('example.caffemodel', 'deploy.prototxt')
coreml_model.save('converted.mlmodel')
```
