/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import model.D_Feedback;
import model.Room;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public class Controller {
    public int CountRoomOfHotel(List<Room> rooms){
        int sum=0;
        for(Room r:rooms){
            sum+=r.getQuantity();
        }
        return sum;
    }
    public List<Integer> D_getFeedbackListByStarRate(int sr, Map<Integer, D_Feedback> listFeedBack){
        List<Integer> result = new ArrayList<>();
        if(sr==0){
            result = new ArrayList<>(listFeedBack.keySet());
            return result;
        }
        else{
            for(Integer key: listFeedBack.keySet()){
                if(listFeedBack.get(key).getRate()==sr){
                    result.add(key);
                }
            }
        }
        return result;
    }
}
