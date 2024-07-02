package com.seller.seller;

import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/sellers")
public class SellerController {

    private Map<String, Seller> sellers = new HashMap<>();

    @PostMapping
    public Seller createSeller(@RequestBody Seller seller) {
        sellers.put(seller.getId(), seller);
        return seller;
    }

    @GetMapping("/{id}")
    public Seller getSeller(@PathVariable String id) {
        return sellers.get(id);
    }

    @GetMapping
    public List<Seller> getAllSellers() {
        return new ArrayList<>(sellers.values());
    }

    @PutMapping("/{id}")
    public Seller updateSeller(@PathVariable String id, @RequestBody Seller seller) {
        sellers.put(id, seller);
        return seller;
    }

    @DeleteMapping("/{id}")
    public void deleteSeller(@PathVariable String id) {
        sellers.remove(id);
    }
}
