package fr.ifremer.acquisition;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;

/**
 * Created by ifremer on 07/07/2017.
 */
@RestController
public class ParameterRestController {

    @Value("${acquisition.sdiv.parameter.file:file:./config/parameter.json}")
    String jsonParameter;

    @Autowired
    private ResourceLoader resourceLoader;

    @RequestMapping(value = "/frontend/parameters", produces = "application/json")
    public ResponseEntity<InputStreamResource> downloadJSONFile() throws IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");

        Resource resource = resourceLoader.getResource(jsonParameter);
        InputStream is = resource.getInputStream();

        return ResponseEntity
            .ok()
            .headers(headers)
            //.contentLength(is)
            .contentType(MediaType.APPLICATION_JSON)
            .body(new InputStreamResource(is));
    }
}
