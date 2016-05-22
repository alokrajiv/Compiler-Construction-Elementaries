
import java.io.*;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class SymbolTable {
    public static void main(String[] args)throws Exception{
        FileReader fr =new FileReader("inp.txt");
        ArrayList<ArrayList<String>> symTbl = new ArrayList<>();
        BufferedReader br =new BufferedReader(fr);
        String str;
        //System.out.println("Enter ! to end:\n You can start enetering values:");
        for(int i = 0; i<7; i++){
            symTbl.add(new ArrayList<>());
        }
        while(true){
            try{
                str = br.readLine();
                if(str==null){
                    break;
                }
                symTbl.get(hashFunc(str)).add(str);
            }catch(Exception e){
                
            }
        }
        System.out.println("\n\nDumping the HashMap:");
        for(int k = 0; k<7; k++){
            System.out.print(k+" => ");
            for(String elem : symTbl.get(k)){
                System.out.print(elem+ " : ");
            }
            System.out.println();
        }
    }
    public static int hashFunc(String str){
        int sum = 0;
        for(int i=0;i<str.length();i++){
            char ch = str.charAt(i);
            if((ch>='A'&&ch<='Z')||(ch>='a'&&ch<='z')){
                sum += (int)ch;
            }
            else if(ch>='0'&&ch<='9'){
                sum += (3 * (int)ch);
            }
        }
        sum = (sum*15+5)%7;
        return sum;
    }
}
