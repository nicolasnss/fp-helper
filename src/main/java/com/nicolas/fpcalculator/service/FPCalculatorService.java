/* Autor: Nicolas - Analista de Sistemas | 2026 */
package com.nicolas.fpcalculator.service;

import com.nicolas.fpcalculator.model.FunctionPoint;
import com.nicolas.fpcalculator.model.FunctionPointComplexity;
import com.nicolas.fpcalculator.model.FunctionPointType;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;

@Service
public class FPCalculatorService {

    public FunctionPoint calcular(String nome,
                                  FunctionPointType tipo,
                                  FunctionPointComplexity complexidade) {
        BigDecimal valor = BigDecimal.valueOf(obterPeso(tipo, complexidade));
        return new FunctionPoint(nome, tipo, complexidade, valor);
    }

    private int obterPeso(FunctionPointType tipo, FunctionPointComplexity complexidade) {
        return switch (tipo) {
            case EE -> switch (complexidade) {
                case BAIXA -> 3;
                case MEDIA -> 4;
                case ALTA -> 6;
            };
            case SE -> switch (complexidade) {
                case BAIXA -> 4;
                case MEDIA -> 5;
                case ALTA -> 7;
            };
            case CE -> switch (complexidade) {
                case BAIXA -> 3;
                case MEDIA -> 4;
                case ALTA -> 6;
            };
            case ALI -> switch (complexidade) {
                case BAIXA -> 7;
                case MEDIA -> 10;
                case ALTA -> 15;
            };
            case AIE -> switch (complexidade) {
                case BAIXA -> 5;
                case MEDIA -> 7;
                case ALTA -> 10;
            };
        };
    }
}

