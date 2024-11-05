package com.example.calculatrice;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;


public class CalculatriceApplicationTests {

    private final Calculatrice calculator = new Calculatrice();  // Instance de Calculator

    @Test
    public void testSum() {
        assertEquals(8, calculator.sum(3, 5));  // Vérifier que la somme est correcte
    }
}