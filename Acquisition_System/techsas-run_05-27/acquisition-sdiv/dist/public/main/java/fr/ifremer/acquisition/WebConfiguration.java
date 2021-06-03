package fr.ifremer.acquisition;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * Configuration enabling Spring MVC only if we do have a web environment
 */
@Configuration
@ConditionalOnWebApplication
public class WebConfiguration implements WebMvcConfigurer {

	// allows to serve resources in classpath:/static when needed only
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String frontend;
        String frontendAcq;

        String workingDirectory = System.getProperty("user.dir");

        /*
         * if we are running via gradle bootRun then the working directory is
         * suffixed with /backend and thus won't find resources correctly
         */
        if (workingDirectory.endsWith("acquisition-launcher")) {
            workingDirectory = workingDirectory.substring(0, workingDirectory.lastIndexOf("acquisition-launcher"));
        }

        /* find front-end build files from the local file system */
        frontend = "file:///" + workingDirectory + "/frontend/visualisation/";
        frontendAcq = "file:///" + workingDirectory + "/frontend/acquisition/";

        registry.addResourceHandler("/**").addResourceLocations(frontend, "classpath:/public/");
        registry.addResourceHandler("/acquisition/**").addResourceLocations(frontendAcq);
	}

	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		registry.addViewController("/").setViewName("forward:/index.html");
        registry.addViewController("/acquisition").setViewName("forward:/acquisition/index.html");
	}
}
