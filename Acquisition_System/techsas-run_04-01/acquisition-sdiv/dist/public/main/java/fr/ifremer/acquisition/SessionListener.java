package fr.ifremer.acquisition;

/**
 * Created by ifremer on 27/12/2016.
 */
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListener implements HttpSessionListener {
    private static final Logger LOG = LoggerFactory.getLogger(WebAppInitializer.class);

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        LOG.info("==== Session is created ====");
        //event.getSession().setMaxInactiveInterval(5*6);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        LOG.info("==== Session is destroyed ====");
    }
}