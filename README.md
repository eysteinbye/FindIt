# FindIt - CoreML/Vision example app

Test machine learning on your iOS device.

## Model

To use the CoreML framework you need a trained model. You can download some models at [Apples Machine Learning page](https://developer.apple.com/machine-learning/).
If you have a model in other formats (like Keras, Caffe, scikit-learn, libsvm, or XGBoost), you can convert it to .mlmodel with the Python tool [coremlutils](https://pypi.python.org/pypi/coremltools).

I had some problems with installing `coremlutils` so I made this [installation guide](docs/CoreMlutils.md).

## How it works

This app will load an image from the Photos Gallery, then use the ml-model to predict the main object in the image.
For each predictions there is a confidence (a number from 0 to 1)

```
beer glass 0.974076
perfume, essence 0.00285238
cocktail shaker 0.000742228
beer bottle 0.000669918
espresso 0.000578004
...
```

From this result we can be quite sure that the image contains a glass of beer.
