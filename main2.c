#include <stdio.h>
#define MAX_STR_LEN (50)

extern int calc_div(int x, int k);

int check(int x, int k){ // this function check for a legal input
    
    if(x<0){
        return 0;
    }
    if((k<0)||(k>31)){
        return 0;
    }    
    return 1;
    
}

int main(int argc, char** argv){
    int num1, num2;
    scanf("%d",&num1);
    scanf("%d",&num2);
    calc_div(num1,num2);
    
    
    return 0;
}
    
