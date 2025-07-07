#include <stdio.h>
#include <stdint.h>
#include <drivers/pwr/adi_pwr.h>

#include "main.h"

typedef struct {
    ADI_GPIO_PORT Port;
    ADI_GPIO_DATA Pins;
} PinMap;

/* LED GPIO assignments */

#ifdef __EVCOG__
PinMap MSB = {ADI_GPIO_PORT2, ADI_GPIO_PIN_10};  /*   Red LED on GPIO42 (DS4) */
PinMap LSB = {ADI_GPIO_PORT2, ADI_GPIO_PIN_2};   /* Green LED on GPIO34 (DS3) */
#else
PinMap MSB = {ADI_GPIO_PORT1, ADI_GPIO_PIN_15};  /*   Red LED on GPIO31 (DS4) */
PinMap LSB = {ADI_GPIO_PORT2, ADI_GPIO_PIN_0};   /* Green LED on GPIO32 (DS3) */
#endif


int main(void)
{
    uint8_t         gpioMemory[ADI_GPIO_MEMORY_SIZE] = {0};
    uint32_t        count = 0;
    ADI_PWR_RESULT  ePwrResult;
    ADI_GPIO_RESULT eGpioResult;

    /* common init */
    common_Init();

    ePwrResult = adi_pwr_Init();
    DEBUG_RESULT("adi_pwr_Init failed.", ePwrResult, ADI_PWR_SUCCESS);

    ePwrResult = adi_pwr_SetClockDivider(ADI_CLOCK_HCLK, 1u);
    DEBUG_RESULT("adi_pwr_SetClockDivider (HCLK) failed.", ePwrResult, ADI_PWR_SUCCESS);

    ePwrResult = adi_pwr_SetClockDivider(ADI_CLOCK_PCLK, 1u);
    DEBUG_RESULT("adi_pwr_SetClockDivider (PCLK) failed.", ePwrResult, ADI_PWR_SUCCESS);

    /* Initialize GPIO driver */
    eGpioResult= adi_gpio_Init(gpioMemory, ADI_GPIO_MEMORY_SIZE);
    DEBUG_RESULT("adi_GPIO_Init failed.", eGpioResult, ADI_GPIO_SUCCESS);

    /* Enable MSB output */
    eGpioResult = adi_gpio_OutputEnable(MSB.Port, MSB.Pins, true);
    DEBUG_RESULT("adi_GPIO_SetOutputEnable failed on MSB.", eGpioResult, ADI_GPIO_SUCCESS);

    /* Enable LSB output */
    eGpioResult = adi_gpio_OutputEnable(LSB.Port, LSB.Pins, true);
    DEBUG_RESULT("adi_GPIO_SetOutputEnable failed on LSB.", eGpioResult, ADI_GPIO_SUCCESS);

    /* Loop indefinitely */
    while (count <= MAX_COUNT)  {

        /* Delay between iterations */
        for (volatile uint32_t i = 0; i < 1000000; i++);

        /* Blink count (mod4) on the LEDs */

        switch (count%4) {
            case 3:
                eGpioResult = adi_gpio_SetHigh (MSB.Port, MSB.Pins);
                DEBUG_RESULT("adi_gpio_SetHigh (MSB).", eGpioResult, ADI_GPIO_SUCCESS);

                eGpioResult = adi_gpio_SetHigh(LSB.Port,  LSB.Pins);
                DEBUG_RESULT("adi_gpio_SetHigh (LSB).", eGpioResult, ADI_GPIO_SUCCESS);
                break;

            case 2:
                eGpioResult = adi_gpio_SetHigh (MSB.Port, MSB.Pins);
                DEBUG_RESULT("adi_gpio_SetHigh (MSB).", eGpioResult, ADI_GPIO_SUCCESS);

                eGpioResult = adi_gpio_SetLow(LSB.Port,  LSB.Pins);
                 DEBUG_RESULT("adi_gpio_SetLow (LSB).", eGpioResult, ADI_GPIO_SUCCESS);
                 break;

            case 1:
                eGpioResult = adi_gpio_SetLow (MSB.Port, MSB.Pins);
                DEBUG_RESULT("adi_gpio_SetLow (MSB).", eGpioResult, ADI_GPIO_SUCCESS);

                eGpioResult = adi_gpio_SetHigh(LSB.Port,  LSB.Pins);
                 DEBUG_RESULT("adi_gpio_SetHigh (LSB).", eGpioResult, ADI_GPIO_SUCCESS);
                 break;

            case 0:
                eGpioResult = adi_gpio_SetLow (MSB.Port, MSB.Pins);
                DEBUG_RESULT("adi_gpio_SetLow (MSB).", eGpioResult, ADI_GPIO_SUCCESS);

                eGpioResult = adi_gpio_SetLow(LSB.Port,  LSB.Pins);
                DEBUG_RESULT("adi_gpio_SetLow (LSB).", eGpioResult, ADI_GPIO_SUCCESS);
                break;

        }

        count++;

    }

    common_Pass();

    return 0;
}
