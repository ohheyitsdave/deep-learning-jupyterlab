# Jupyterlab

Release 2019.05 contains the following packages:

- Python 3.6
- Jupyter
- Jupyterlab:
- Numpy
- Pandas
- Tensorflow
- Tensorflow Tensorboard
- Keras
- Pytorch

## Download 
```bash
docker pull ohheyitsdave/deep-learning-jupyterlab
```

## Run
To run the environment on port 8888, use the following docker command:

```bash
docker run -d -p=<host-port>:<container-port> --name <container-name> dlackovic/jupyterlab
```

For example:
```bash
docker run -d -p=8888:8888 --name jupyterlab dlackovic/jupyterlab
```

To share a folder with the environment, use following command:
```bash
-v <host-directory>:<container-path>
```
For example:
```bash
docker run -d -p=8888:8888 -v ~/path/to/notebooks:/notebooks  --name jupyterlab dlackovic/jupyterlab 
```

Alternative navigate to the folder you want to share with jupyer and use the `$(pwd)` to get current path:
```bash
docker run --rm -it -p 8888:8888 -v "$(pwd):/notebooks" jupyter/notebook 
```
Note:
* In Windows Command Line `(cmd)`, you can mount the current directory like so.
* In PowerShell, you use `${PWD}`, which gives you the current directory.

## Use
Open your browser and type in: 'localhost:8888'. 
If you want to know more about how to use Jupyter Notebook, [here are some tutorials.][1] to get you started. 

## TODO: 
- /data - files in here that can be accessed by scripts that look under this path
- /output - scripts write their output to files under here, to make it available to the host system
- /var/logs - logs files

  [1]:  http://jupyterlab.readthedocs.io/en/latest/