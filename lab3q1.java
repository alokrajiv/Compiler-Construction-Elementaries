import java.util.*;
import java.util.ArrayList;
public class lab3q1{
    public static void main(String[] args){
        Scanner sc = new Scanner(System.in);
        ArrayList[] hash = new ArrayList[7];
        for(int i=0;i<7;i++){
            hash[i] = new ArrayList<String>();
        }
        for(int i=0;i<20;i++){
            String str = sc.nextLine();
            int sum=0;
            for(int j=0;j<str.length();j++){
                if(j==1)
                sum = sum + (3*str.charAt(j));
                else
                sum = sum + str.charAt(j);
            }
            sum = sum*15;
            //sum = sum+5;
           // System.out.println(sum);
            sum = sum%7;
            hash[sum].add(str);
            
        }
        for(int i=0;i<7;i++){
            System.out.print(i);
            for(int j=0;j<hash[i].size();j++){
                System.out.print(" "+hash[i].get(j));
            }
            System.out.println("");
        }
         
    }
}
