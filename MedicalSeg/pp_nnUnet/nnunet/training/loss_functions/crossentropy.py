from paddle import nn, Tensor
import paddle

class RobustCrossEntropyLoss(nn.CrossEntropyLoss):
    """
    this is just a compatibility layer because my target tensor is float and has an extra dimension
    """
    def forward(self, input: Tensor, target: Tensor) -> Tensor:
        if len(target.shape) == len(input.shape):
            assert target.shape[1] == 1
            target = target[:, 0]
        # import pdb
        # pdb.set_trace()
        if len(input.shape)==5:
            input=input.transpose([0,2,3,4,1])
        elif len(input.shape)==4:
            input = input.transpose([0, 2, 3, 1])
        target=paddle.cast(target,"int64")
        return super().forward(input, target)