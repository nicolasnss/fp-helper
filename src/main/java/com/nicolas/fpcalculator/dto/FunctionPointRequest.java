/* Autor: Nicolas - Analista de Sistemas | 2026 */
package com.nicolas.fpcalculator.dto;

import com.nicolas.fpcalculator.model.FunctionPointComplexity;
import com.nicolas.fpcalculator.model.FunctionPointType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

public record FunctionPointRequest(
        @NotBlank String nome,
        @NotNull FunctionPointType tipo,
        @NotNull FunctionPointComplexity complexidade
) {
}

