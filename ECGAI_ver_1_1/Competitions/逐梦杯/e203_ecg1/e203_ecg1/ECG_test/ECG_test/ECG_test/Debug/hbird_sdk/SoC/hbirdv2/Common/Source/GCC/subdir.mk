################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../hbird_sdk/SoC/hbirdv2/Common/Source/GCC/intexc_hbirdv2.S \
../hbird_sdk/SoC/hbirdv2/Common/Source/GCC/startup_hbirdv2.S 

OBJS += \
./hbird_sdk/SoC/hbirdv2/Common/Source/GCC/intexc_hbirdv2.o \
./hbird_sdk/SoC/hbirdv2/Common/Source/GCC/startup_hbirdv2.o 

S_UPPER_DEPS += \
./hbird_sdk/SoC/hbirdv2/Common/Source/GCC/intexc_hbirdv2.d \
./hbird_sdk/SoC/hbirdv2/Common/Source/GCC/startup_hbirdv2.d 


# Each subdirectory must supply rules for building sources it contributes
hbird_sdk/SoC/hbirdv2/Common/Source/GCC/%.o: ../hbird_sdk/SoC/hbirdv2/Common/Source/GCC/%.S
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross Assembler'
	riscv-nuclei-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -mno-save-restore -O0 -ffunction-sections -fdata-sections -fno-common  -g -x assembler-with-cpp -DDOWNLOAD_MODE=DOWNLOAD_MODE_FLASH -D__IDE_RV_CORE=e203 -DSOC_HBIRDV2 -DBOARD_MCU200T -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\application" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\NMSIS\Core\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Common\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Board\mcu200t\Include" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


