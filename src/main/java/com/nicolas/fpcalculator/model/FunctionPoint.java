/* Autor: Nicolas - Analista de Sistemas | 2026 */
package com.nicolas.fpcalculator.model;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;

public class FunctionPoint {

    @NotBlank
    private String nome;

    @NotNull
    private FunctionPointType tipo;

    @NotNull
    private FunctionPointComplexity complexidade;

    @NotNull
    @DecimalMin(value = "0.0", inclusive = true)
    private BigDecimal valorCalculado;

    public FunctionPoint() {
        // Construtor padrão para frameworks e serialização
    }

    public FunctionPoint(String nome,
                         FunctionPointType tipo,
                         FunctionPointComplexity complexidade,
                         BigDecimal valorCalculado) {
        this.nome = nome;
        this.tipo = tipo;
        this.complexidade = complexidade;
        this.valorCalculado = valorCalculado;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public FunctionPointType getTipo() {
        return tipo;
    }

    public void setTipo(FunctionPointType tipo) {
        this.tipo = tipo;
    }

    public FunctionPointComplexity getComplexidade() {
        return complexidade;
    }

    public void setComplexidade(FunctionPointComplexity complexidade) {
        this.complexidade = complexidade;
    }

    public BigDecimal getValorCalculado() {
        return valorCalculado;
    }

    public void setValorCalculado(BigDecimal valorCalculado) {
        this.valorCalculado = valorCalculado;
    }
}

