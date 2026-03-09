/* Autor: Nicolas - Analista de Sistemas | 2026 */
package com.nicolas.fpcalculator.controller;

import com.nicolas.fpcalculator.dto.FunctionPointRequest;
import com.nicolas.fpcalculator.model.FunctionPoint;
import com.nicolas.fpcalculator.service.FPCalculatorService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/function-points")
public class FPCalculatorController {

    private final FPCalculatorService fpCalculatorService;

    public FPCalculatorController(FPCalculatorService fpCalculatorService) {
        this.fpCalculatorService = fpCalculatorService;
    }

    @PostMapping
    public ResponseEntity<FunctionPoint> calcular(@Valid @RequestBody FunctionPointRequest request) {
        FunctionPoint functionPoint = fpCalculatorService.calcular(
                request.nome(),
                request.tipo(),
                request.complexidade()
        );
        return ResponseEntity.ok(functionPoint);
    }
}

