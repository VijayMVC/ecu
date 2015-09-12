package battle.saucers.controllers;

import battle.Constants;
import battle.sensors.SensorData;

import java.awt.*;
import java.util.ArrayList;

/**
 * RoyalRumble fuzzy controller.
 *
 * @author Martin Ponce, 10371381
 * @version 20150911
 */
public class RoyalRumbleController implements SaucerController, Constants {

    // saucer config
    private static final String NAME = "RoyalRumble";
    private static final Color BASE = Color.yellow;
    private static final Color ARROW = Color.black;

    private SensorData target;
    private SensorData nearestBlast;
    private SensorData nearestPowerUp;

    private double energy;
    private boolean isPowerUp;

    /**
     * Constructor.
     */
    public RoyalRumbleController() {
        // fuzzy variables, rules here
    }

    @Override
    public void senseSaucers(ArrayList<SensorData> data) throws Exception {
        // get nearest enemy
        if(data.size() > 0) {
            double closest = data.get(0).distance;
            target = data.get(0);

            for(SensorData thisData : data) {
                if(thisData.distance < closest) {
                    target = thisData;
                    closest = thisData.distance;
                }
            }
        } else {
            target = null;
        }
    }

    @Override
    public void sensePowerUps(ArrayList<SensorData> data) throws Exception {

        isPowerUp = data.size() > 0;

        // if any powerUp's exist, get nearest
        if(isPowerUp) {
            double closest = data.get(0).distance;
            nearestPowerUp = data.get(0);

            for(SensorData thisData : data) {
                if(thisData.distance < closest) {
                    nearestPowerUp = thisData;
                    closest = thisData.distance;
                }
            }
        } else {
            nearestPowerUp = null;
        }
    }

    @Override
    public void senseBlasts(ArrayList<SensorData> data) throws Exception {
        // get nearest blast
        if(data.size() > 0) {
            double closest = data.get(0).distance;
            nearestBlast = data.get(0);

            for(SensorData thisData : data) {
                if(thisData.distance < closest) {
                    nearestBlast = thisData;
                    closest = thisData.distance;
                }
            }
        } else {
            nearestBlast = null;
        }
    }

    @Override
    public void senseEnergy(double energy) throws Exception {
        this.energy = energy;
    }

    @Override
    public SensorData getTarget() throws Exception {
        return null;
    }

    @Override
    public double getFirePower() throws Exception {
        return 0;
    }

    @Override
    public double getSpeed() throws Exception {
        return 0;
    }

    @Override
    public double getTurn() throws Exception {
        return 0;
    }

    @Override
    public boolean getShields() throws Exception {
        return false;
    }

    @Override
    public String getName() {
        return NAME;
    }

    @Override
    public Color getBaseColor() {
        return BASE;
    }

    @Override
    public Color getTurretColor() {
        return ARROW;
    }
}