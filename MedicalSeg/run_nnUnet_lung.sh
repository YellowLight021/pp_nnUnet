mkdir -p /home/aistudio/nnLung
cd /home/aistudio/nnLung
mkdir -p nnUNet_raw
mkdir -p nnUNet_preprocessed
mkdir -p nnUNet_trained_models
trained_model=/home/aistudio/nnLung/nnUNet_trained_models
export nnUNet_raw_data_base="/home/aistudio/nnLung/nnUNet_raw"
export nnUNet_preprocessed="/home/aistudio/nnLung/nnUNet_preprocessed"
export RESULTS_FOLDER="/home/aistudio/nnLung/nnUNet_trained_models"
cd /home/aistudio/MedicalSeg3D/tools/experiment_planning
python nnUNet_convert_decathlon_task.py -i /home/aistudio/Dataset/Task06_Lung
cd /home/aistudio/MedicalSeg3D/tools/experiment_planning
python nnUnet_plan_and_preprocess.py -t 6
cd /home/aistudio/MedicalSeg3D
python run_training.py 2d nnUNetTrainerV2 6 4 --npz --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 2d nnUNetTrainerV2 6 3 --npz --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 2d nnUNetTrainerV2 6 2 --npz --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 2d nnUNetTrainerV2 6 1 --npz --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 2d nnUNetTrainerV2 6 0 --npz --max_num_epochs 1000 --num_batches_per_epoch 250
cd /home/aistudio/MedicalSeg3D
python run_training.py 3d_lowres nnUNetTrainerV2 6 4 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_lowres nnUNetTrainerV2 6 3 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_lowres nnUNetTrainerV2 6 2 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_lowres nnUNetTrainerV2 6 1 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_lowres nnUNetTrainerV2 6 0 --max_num_epochs 1000 --num_batches_per_epoch 250
cd /home/aistudio/MedicalSeg3D
python run_training.py 3d_cascade_fullres nnUNetTrainerV2 6 4 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_cascade_fullres nnUNetTrainerV2 6 3 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_cascade_fullres nnUNetTrainerV2 6 2 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_cascade_fullres nnUNetTrainerV2 6 1 --max_num_epochs 1000 --num_batches_per_epoch 250
python run_training.py 3d_cascade_fullres nnUNetTrainerV2 6 0 --max_num_epochs 1000 --num_batches_per_epoch 250
cd /home/aistudio/MedicalSeg3D
python nn_unet_export.py --plan ${trained_model}/nnUNet/3d_lowres/Task006_Lung/nnUNetTrainerV2__nnUNetPlansv2.1/fold_4/model_final_checkpoint.model.pkl \
--check_point ${trained_model}/nnUNet/3d_lowres/Task006_Lung/nnUNetTrainerV2__nnUNetPlansv2.1/fold_4/model_final_checkpoint.model \
--stage 0 \
--save_dir /home/aistudio/output_model/3d_lowres

python nn_unet_export.py --plan ${trained_model}/nnUNet/3d_cascade_fullres/Task006_Lung/nnUNetTrainerV2__nnUNetPlansv2.1/fold_4/model_final_checkpoint.model.pkl \
--check_point ${trained_model}/nnUNet/3d_cascade_fullres/Task006_Lung/nnUNetTrainerV2__nnUNetPlansv2.1/fold_4/model_final_checkpoint.model \
--stage 0 \
--save_dir /home/aistudio/output_model/3d_cascade_fullres

cd /home/aistudio/MedicalSeg3D
python deploy/python/nnUnet_infer.py --model_path /home/aistudio/output_model/3d_cascade_fullres \
--image_path /home/aistudio/test_image \
--save_dir /home/aistudio/output_result/cas \
--lower_path  /home/aistudio/output_model/3d_lowres \
--model_name 3d_cascade_fullres




