package Javaday2;

public class patter10 {
    public static void main(String[] args) {
        for (int i=1;i<6;i++)
        {
            for(int j=1;j<10;j++)
            {
                if((i%5==0 && j%2==0)||(i%4==0 && (j%5==0||j%4==3)) || (i%3==0 && (j%6==0 || j%6==4)) ||(i%2==0 && j%5==0))
                {
                    System.out.print(i-1);
                }
                else if((j%5==0 && i%2==1)||(i%5==0 && i%2==1)||(i%4==0 && j%2==0)||(i%3==0 && j%4==3)||(i%2==0 && (j%6==0 || j%6==4)))
                {
                    System.out.print("*");
                }
                else
                {
                    System.out.print(" ");
                }
            }
            System.out.println();
        }
        for(int i=6;i<10;i++)
        {
            for(int j=1;j<10;j++)
            {
                if((j%5==0 && i%2==1)||(i%6==0 && j%2==0)||(i%7==0 && j%4==3)||(i%8==0 && (j%6==0 || j%6==4)))
                {
                    System.out.print("*");
                }
                else if((i%6==0 &&(j%5==0||j%4==3)) || (i%7==0 && (j%6==0 || j%6==4)) || (i%8==0 && j%5==0))
                {
                    System.out.print(9-i);
                }
                else
                {
                    System.out.print(" ");
                }
            }
             System.out.println();
        }
    }
}
