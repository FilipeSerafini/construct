package com.seller.seller;

import java.util.List;

public class Seller {

    private String id;
    private ContaRecebimento contaRecebimento;
    private List<String> listaIngressos;

    public String getId() {
        return id;
        
    }

    public void setId(String id) {
        this.id = id;
    }
}

class ContaRecebimento {
    private String codigoBanco;
    private String agencia;
    private String contaCorrente;
}
