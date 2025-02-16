/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Validation;

/**
 *
 * @author Asus
 */
public class CheckValidation {

    public CheckValidation() {
    }

    public int D_validationInt(String inputInt, int min, int max) {
        int validInt = -1;
        try {
            validInt = Integer.parseInt(inputInt);
            if (validInt < min || validInt > max) {
                throw new Exception();
            }
        } catch (Exception e) {
            return -1;
        }
        return validInt;
    }

    public boolean isValidPhoneNumber(String phone) {
        return phone != null && phone.matches("^0\\d{9,10}$");
    }

}
