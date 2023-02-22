################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../hbird_sdk/SoC/hbirdv2/Common/Source/hbirdv2_common.c \
../hbird_sdk/SoC/hbirdv2/Common/Source/system_hbirdv2.c 

OBJS += \
./hbird_sdk/SoC/hbirdv2/Common/Source/hbirdv2_common.o \
./hbird_sdk/SoC/hbirdv2/Common/Source/system_hbirdv2.o 

C_DEPS += \
./hbird_sdk/SoC/hbirdv2/Common/Source/hbirdv2_common.d \
./hbird_sdk/SoC/hbirdv2/Common/Source/system_hbirdv2.d 


# Each subdirectory must supply rules for building sources it contributes
hbird_sdk/SoC/hbirdv2/Common/Source/%.o: ../hbird_sdk/SoC/hbirdv2/Common/Source/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-nuclei-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -mno-save-restore -O0 -ffunction-sections -fdata-sections -fno-common  -g -DDOWNLOAD_MODE=DOWNLOAD_MODE_FLASH -D__IDE_RV_CORE=e203 -DSOC_HBIRDV2 -DBOARD_MCU200T -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\application" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\NMSIS\Core\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Common\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Board\mcu200t\Include" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


