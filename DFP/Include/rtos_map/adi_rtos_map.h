/*!
 *****************************************************************************
 @file:    adi_rtos_map.h
 @brief:   RTOS API mapping file.
           This is the main RTOS mapping header file which will include other
           RTOS mapping files based on the RTOS selection.
           
           The purpose of RTOS mapping file is for mapping the abstracted
           RTOS macros to the RTOS API calls based on the chosen RTOS.
           
           NOTE: This file is intended to be used by only the drivers. Not at 
                 the application level.
           
 -----------------------------------------------------------------------------
Copyright (c) 2016 Analog Devices, Inc.

All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
  - Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  - Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  - Modified versions of the software must be conspicuously marked as such.
  - This software is licensed solely and exclusively for use with processors
    manufactured by or for Analog Devices, Inc.
  - This software may not be combined or merged with other code in any manner
    that would cause the software to become subject to terms and conditions
    which differ from those listed here.
  - Neither the name of Analog Devices, Inc. nor the names of its
    contributors may be used to endorse or promote products derived
    from this software without specific prior written permission.
  - The use of this software may or may not infringe the patent rights of one
    or more patent holders.  This license does not release you from the
    requirement that you obtain separate licenses from these patent holders
    to use this software.
THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES, INC. AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, NON-
INFRINGEMENT, TITLE, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL ANALOG DEVICES, INC. OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, PUNITIVE OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, DAMAGES ARISING OUT OF
CLAIMS OF INTELLECTUAL PROPERTY RIGHTS INFRINGEMENT; PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*****************************************************************************/
#ifndef ADI_RTOS_MAP_H
#define ADI_RTOS_MAP_H

#include <adi_global_config.h>

#if   (ADI_CFG_RTOS == ADI_CFG_RTOS_MICRIUM_III)
    
#include "rtos_map/adi_rtos_map_ucos_iii.h"

#elif   (ADI_CFG_RTOS == ADI_CFG_RTOS_MICRIUM_II)
    
#include "rtos_map/adi_rtos_map_ucos_ii.h"

#elif (ADI_CFG_RTOS == ADI_CFG_RTOS_FREERTOS)
    
#include "rtos_map/adi_rtos_map_freertos.h"

#elif (ADI_CFG_RTOS == ADI_CFG_RTOS_THREADX)
    
#include "rtos_map/adi_rtos_map_threadx.h"

#else 
    
#include "rtos_map/adi_rtos_map_noos.h"

#endif /* ADI_CFG_RTOS_MICRIUM_III */ 

#endif /* ADI_RTOS_MAP_H */
