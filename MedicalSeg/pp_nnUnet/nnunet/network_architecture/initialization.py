
import paddle.fluid.framework
from paddle import nn

class InitWeights_He(object):
    def __init__(self, neg_slope=1e-2):
        self.neg_slope = neg_slope

    def __call__(self, module):
        if isinstance(module, nn.Conv3D) or isinstance(module, nn.Conv2D) or isinstance(module, nn.Conv2DTranspose) or isinstance(module, nn.Conv3DTranspose):
            module.weight = nn.initializer.KaimingNormal()
            if module.bias is not None:
                module.bias = nn.initializer.Constant(0)


class InitWeights_XavierUniform(object):
    def __init__(self, gain=1):
        self.gain = gain

    def __call__(self, module):
        if isinstance(module, nn.Conv3D) or isinstance(module, nn.Conv2D) or isinstance(module, nn.Conv2DTranspose) or isinstance(module, nn.Conv3DTranspose):
            module.weight = paddle.nn.initializer.XavierUniform()
            if module.bias is not None:
                module.bias = nn.initializer.Constant(0)
