################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../.metadata/.plugins/org.eclipse.cdt.make.core/specs.c 

CPP_SRCS += \
../.metadata/.plugins/org.eclipse.cdt.make.core/specs.cpp 

OBJS += \
./.metadata/.plugins/org.eclipse.cdt.make.core/specs.o 

C_DEPS += \
./.metadata/.plugins/org.eclipse.cdt.make.core/specs.d 

CPP_DEPS += \
./.metadata/.plugins/org.eclipse.cdt.make.core/specs.d 


# Each subdirectory must supply rules for building sources it contributes
.metadata/.plugins/org.eclipse.cdt.make.core/%.o: ../.metadata/.plugins/org.eclipse.cdt.make.core/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C Compiler'
	riscv-nuclei-elf-gcc -march=rv32imac -mabi=ilp32 -mcmodel=medany -mno-save-restore -O0 -ffunction-sections -fdata-sections -fno-common  -g -DDOWNLOAD_MODE=DOWNLOAD_MODE_FLASH -D__IDE_RV_CORE=e203 -DSOC_HBIRDV2 -DBOARD_MCU200T -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\application" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\NMSIS\Core\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Common\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Board\mcu200t\Include" -std=gnu11 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

.metadata/.plugins/org.eclipse.cdt.make.core/%.o: ../.metadata/.plugins/org.eclipse.cdt.make.core/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GNU RISC-V Cross C++ Compiler'
	riscv-nuclei-elf-g++ -march=rv32imac -mabi=ilp32 -mcmodel=medany -mno-save-restore -O0 -ffunction-sections -fdata-sections -fno-common  -g -DDOWNLOAD_MODE=DOWNLOAD_MODE_FLASH -D__IDE_RV_CORE=e203 -DSOC_HBIRDV2 -DBOARD_MCU200T -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\application" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\NMSIS\Core\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Common\Include" -I"D:\FPGA\e203_ecgV0.2\e203_ecg1\ECG_test\ECG_test\ECG_test\hbird_sdk\SoC\hbirdv2\Board\mcu200t\Include" -std=gnu++11 -fabi-version=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -c -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


