package com.dashcode.ner_logistic;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@SpringBootApplication
@RestController
public class NerLogisticApplication {

	public static void main(String[] args) {
		SpringApplication.run(NerLogisticApplication.class, args);
	}

	@GetMapping("/api/health")
	public Map<String, String> health() {
		return Map.of(
			"status", "OK",
			"service", "NER Smart Logistics Backend"
		);
	}

}
