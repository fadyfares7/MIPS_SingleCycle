#include <iostream>
#include <string>
#include <algorithm>
#include <fstream>
#include <sstream>
#include <cmath>
using namespace std;


//////////////////////////////////
void eraseSpaces(string &line);
void lowerCase(string &line);
bool removeAnyComments(string &line);
bool assemble(string line[],int count,string jump[][2]);
int setOpcodeAndFunction(string line,string &instruction);
string registerNumber(string name);
string binary(int a,int length);
string twosComplement(string line);
string getRegister(string line,int regNum);
string findNum (string x,string z);
string calculateJumpAddress(string line,int lineNum,string type,string x[50][2]);
int searchFor(string word,string jump[50][2]);
void removeJumpstatements(string line[],int count,string jump[][2]);
string convertNumToString(int number);
//////////////////////////////////


int main()
{
string fileName;
string line[50];
int count=0;
string jump[50][2];
int j=0;

cout << "Enter the name of the test file with the file extension " << endl ;
cin >> fileName ;


ifstream M (fileName) ;   // Open the file
//Read everyline from the file

while (! M.eof()) {
getline (M,line[count]);
if (removeAnyComments(line[count])==1)continue;
eraseSpaces(line[count]);
lowerCase(line[count]);
if (line[count].length()==0) continue;
count++;
}

removeJumpstatements(line,count,jump);

for (int i=0;i<count;i++){
if (line[i].length()==0) continue;
line[j]=line[i];
j++;
}

if (assemble(line,count,jump)==0)
cout << "wrong input" << endl ;

cout << " The memory list file in the MIPS folder is overwritten with your new code " << endl ;
system("pause");
return 0;
}


// erase all spaces in a string
// return a string without any spaces
void eraseSpaces(string &line){
	line.erase(remove_if(line.begin(), line.end(), isspace),line.end());
}

// replace any capital letters with lowercased one
void lowerCase(string &line){
		transform(line.begin(), line.end(), line.begin(), ::tolower);
}


// remove any comments from a line 
// case the line is only a comment 
// it returns the true
bool removeAnyComments(string &line){
	int	i;
if (line.find("//")==0)
	return true;
else if (line.find("//")>0)
{
	i=line.find("//");
	line = line.substr(0,i);
	return false;
}
return false;
}

bool assemble(string line[],int count,string jump[][2]){
	ofstream W("../MIPS/memory.list");
	string instruction;
	string registers;
	int number;
	for (int i=0;i<count;i++){
		 instruction="00000000000000000000000000000000";
	number=setOpcodeAndFunction(line[i],instruction);
	switch (number){
		case 1:
			registers=getRegister(line[i],3);
			instruction.replace(16,5,registers.substr(0,5));
			instruction.replace(6,5,registers.substr(5,5));
			instruction.replace(11,5,registers.substr(10,5));
			instruction.replace(21,5,"00000");
			break;
		case 2:
			registers=getRegister(line[i],2);
			instruction.replace(6,5,"00000");
			instruction.replace(11,5,registers.substr(5,5));
			instruction.replace(16,5,registers.substr(0,5));
			instruction.replace(21,5,findNum(line[i],"R"));
			break;
		case 3:
			registers=getRegister(line[i],1);
			instruction.replace(11,15,"000000000000000");
			instruction.replace(6,5,registers.substr(0,5));
			break;
		case 4: 
			registers=getRegister(line[i],2);
			instruction.replace(11,5,registers.substr(0,5));
			instruction.replace(6,5,registers.substr(5,5));
			instruction.replace(16,16,findNum(line[i],"I"));
			break;
		case 5:
			instruction.replace(6,26,calculateJumpAddress(line[i],i+1,"absolute",jump));
			break;
		case 6: 
			registers=getRegister(line[i],1);
			instruction.replace(6,5,"00000");
			instruction.replace(11,5,registers.substr(0,5));
			instruction.replace(16,16,findNum(line[i],"I"));
			break;
		case 7: 
			registers=getRegister(line[i],2);
			instruction.replace(6,5,registers.substr(5,5));
			instruction.replace(11,5,registers.substr(0,5));
			instruction.replace(16,16,findNum(line[i],"I"));
			break;
		case 8:
			registers=getRegister(line[i],2);
			instruction.replace(6,5,registers.substr(5,5));
			instruction.replace(11,5,registers.substr(0,5));
			instruction.replace(16,16,calculateJumpAddress(line[i],i,"relative",jump));
			break;
		default: break;
	}
	//cout << instruction << endl ;
	W << instruction.substr(0,8) << endl ;
	W << instruction.substr(8,8) << endl;
	W << instruction.substr(16,8)<<  endl ;
	W << instruction.substr(24,8)<< endl;
	}
	
return true;
}

// set the op code and function of an instruction
int setOpcodeAndFunction(string line,string &instruction){
	if (line.find("add")==0 && line.find("addi")!=0 ){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"100000");
		return 1;} // for R type with three registers}
	else if (line.find("sub")==0){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"100010");
		return 1;}
	else if (line.find("mul")==0){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"011000");
		return 1;}
	else if (line.find("and")==0 && line.find("andi")!=0 ){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"100100");
		return 1;}
	else if (line.find("or")==0 && line.find("ori")!=0){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"100101");
		return 1;}
	else if (line.find("nor")==0){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"100111");
		return 1;}
	else if (line.find("sll")==0){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"000000");
		return 2;} // R type instructions with two registers and shift amount
	else if (line.find("srl")==0){
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"000010");
		return 2; }
	else if (line.find("slt")==0 && line.find("sltu")!=0 && line.find("slti")!=0 && line.find("sltiu")!=0)
		{
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"101010");
		return 1; }
	else if (line.find("sltu")==0)
			{
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"101001");
		return 1; }
	else if (line.find("jr")==0)
					{
		instruction.replace(0,6,"000000");
		instruction.replace(26,6,"001000");
		return 3; } // R type jr instruction
	else if (line.find("addi")==0)
			{
		instruction.replace(0,6,"001000");
		return 4; } //  I type with two registers and immediate number
	else if (line.find("andi")==0)
					{
		instruction.replace(0,6,"001100");
		return 4; }
	else if (line.find("ori")==0)
					{
		instruction.replace(0,6,"001101");
		return 4; }
	else if (line.find("slti")==0 && line.find("sltiu")!=0)
					{
		instruction.replace(0,6,"001010");
		return 4; }
	else if (line.find("sltiu")==0)
					{
		instruction.replace(0,6,"001001");
		return 4; }
	else if (line.find("j")==0 && line.find("jal")!=0 && line.find("jr")!=0)
					{
		instruction.replace(0,6,"000010");
		return 5; } // jump 
	else if (line.find("jal")==0)
					{
		instruction.replace(0,6,"000011");
		return 5; }
	else if (line.find("beq")==0)
					{
		instruction.replace(0,6,"000100");
		return 8; }
	else if (line.find("bne")==0)
					{
		instruction.replace(0,6,"000101");
		return 8; }
	else if (line.find("lui")==0)
					{
		instruction.replace(0,6,"001111");
		return 6; } // lui for one register and immediate number
	else if (line.find("lb")==0 && line.find("lbu")!=0)
					{
		instruction.replace(0,6,"100000");
		return 7; }
	else if (line.find("lbu")==0)
					{
		instruction.replace(0,6,"100100");
		return 7; } // for load and store instructions
	else if (line.find("lh")==0 && line.find("lhu")!=0)
					{
		instruction.replace(0,6,"100001");
		return 7; }
	else if (line.find("lhu")==0)
					{
		instruction.replace(0,6,"100101");
		return 7; }
	else if (line.find("lw")==0)
					{
		instruction.replace(0,6,"100011");
		return 7; }
	else if (line.find("sb")==0)
					{
		instruction.replace(0,6,"101000");
		return 7; }
	else if (line.find("sh")==0)
					{
		instruction.replace(0,6,"101001");
		return 7; }
	else if (line.find("sw")==0)
					{
		instruction.replace(0,6,"101011");
		return 7; }
	else return 0;
}


// passing the register name with dollar sign 
// it returns an integer of the register number
string registerNumber(string name){
	int length = name.length();
	short number = atoi(name.substr(2,1).c_str());
	string reg = name.substr(1,2);

	if (name.substr(0,1) == "$"){
		if (length == 5 && name.substr(1,4) == "zero") 
			return binary(0,5);		
		else if (length == 3){
			if (reg == "gp")			
				return binary(28,5);
			else if(reg=="sp")			
				return binary(29,5);
			else if(reg=="fp")			
				return binary(30,5);
			else if(reg=="ra")			
				return binary(31,5);
			else if (reg=="at")			
				return binary(1,5);
			else if (name[2]=='0' || number >0 ){
					if (name[1] == 's' && number <=7)	
						return binary(16+number,5);
					else if (name[1] == 'v' && number <2)	
						return binary(2+number,5);
					else if (name[1] == 't')
						if (number <= 7)	
										return binary(8+number,5);
						else if (number == 8 || number == 9)
										return binary(16+number,5);
						else return binary(-1,5);
					else if (name[1] == 'k' && number <= 1)	
						return binary(26+number,5);
					else if (name[1] == 'a' && number <= 3)	
						return binary(4+number,5);
					else if (atoi(reg.c_str())>9 && atoi(reg.c_str())<=31)
						return binary(atoi(reg.c_str()),5);
					else return binary(-1,5);
			}
			else return binary(-1,5);
		}
		else if (length == 2){
			number =  atoi(name.substr(1,1).c_str());
			if (name[1]=='0'||(number>0 && number<=9))
				return binary(number,5);
			else return binary(-1,5);}
		else return binary(-1,5);
	}
	else return binary(-1,5);
}

// passing an integer and a required 
// length to the binary number 
string binary(int a,int length){
	string y;
	int k,s=a;
	a=abs(a);
for (int c = length-1; c >= 0; c--)
  {
    k = a >> c;
    if (k & 1)
		y+="1";
    else
		y+="0";
	}
if(s<0)
	return twosComplement(y);
else
return y;
}

// returns the two's complement of a string of numbers
string twosComplement(string line){
	string character;
	int count =0;
	string y;
	for (int i=line.length()-1;i>=0;i--){
		character=line.substr(i,1);
		if (count == 0){
			if(character=="0")
				y="0"+y;
			else if (character=="1"){
			count=1;
			y="1"+y;
			}
		}
		else if (count==1){
			if (character=="0")y="1"+y;
			else y="0"+y;
		}
	}
	return y;
}

string getRegister(string line,int regNum){
	int i=0,k,s=0;
	//cout << line << endl ;
	//eraseUnwantedCharacters(line);
	if ((line.find("(")>0 && line.find("(")<line.length())) s=1;
	string m;
	while (line.find("$")){
	regNum--;
	i=line.find("$",i+1);
	if ( regNum<0 ) break ;
	if ( line.find(",",i) ) k=line.find(",",i);
	else k=line.find(")",i);
	if(k>0)
		m=m+registerNumber(line.substr(i,k-i));
	else{
	m=m+registerNumber(line.substr(i,line.length()-i-s));
	}
	}
	
return m;
}

string findNum (string x,string z){
	int i,j;
	string y;
	i=x.find_last_of(",");
	if (z=="I"){
		if ( x.find("(") > 0 && x.find("(")<x.length()){
			j=x.find("(");
			y=x.substr(i+1,j-i-1);
			return binary(atoi(y.c_str()),16);
		}
		else{
			y=x.substr(i+1,x.length()-i-1);
			return binary(atoi(y.c_str()),16);
			}
	}
	else if (z=="R"){
		y=x.substr(i+1,x.length()-1);
		return binary(atoi(y.c_str()),5);}
	}

string calculateJumpAddress(string line,int lineNum,string type,string x[50][2]){
	int i;
	string jump;
	if (type=="relative"){
		i=line.find_last_of(",");
		jump=line.substr(i+1,line.length()-i-1);
		i=searchFor(jump,x)-(lineNum+1);
		return binary(i,16);}
	else if (type == "absolute"){
		if (line.find("jal")==0)
			jump=line.substr(3,line.length()-3);
		else if (line.find("j")==0)
			jump=line.substr(1,line.length()-1);
	//	cout << jump << endl ;
		i=searchFor(jump,x);
	//	cout << i << endl ;
		return binary(i,26);
	}
}

int searchFor(string word,string jump[50][2]){
	for (int i=0;i<50;i++)
		if (word==jump[i][0])
			return atoi(jump[i][1].c_str());
}

// make a list of the jump words in the program and the lines 
// they are written, also remove them from the code line 
void removeJumpstatements(string line[],int count,string jump[][2]){
	int j=0,k=0;
		for (int i=0;i<count;i++){
			if (line[i].find(":")==line[i].length()-1)
			{	
				jump[j][0]=line[i].substr(0,line[i].length()-1);
				jump[j][1]=convertNumToString(i-k);
				line[i].erase(0,line[i].length());
				j++ ;
				k++;
			}
			else if ((line[i].find(":"))>0 && line[i].find(":") < line[i].length())
			{
				jump[j][0]=line[i].substr(0,line[i].find(":"));
				jump[j][1]=convertNumToString(i-k);
				line[i].erase(0,line[i].find(":")+1);
				j++ ;
			}
			
			//cout << line[i] << endl ;
		}

		//for (int i=0 ; i < 5 ; i++)
			//for (int j=0; j<2;j++)
			//	cout << jump[i][j] << endl ;
}

// convert a number to a string
string convertNumToString(int number){
	
string Result; 
ostringstream convert;
convert << number;
Result = convert.str();
while (Result.length() != 5)
return Result;
}
