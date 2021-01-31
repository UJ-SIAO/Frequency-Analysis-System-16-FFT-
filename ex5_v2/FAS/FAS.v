module FAS(
       clk, 
       rst, 
       data_valid, 
       data, 
       fft_d0,fft_d1,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,fft_d7,
       fft_d8,fft_d9,fft_d10,fft_d11,fft_d12,fft_d13,fft_d14,fft_d15,
       fft_valid,
       done,
       freq
       );
       
input	clk;
input	rst;
input	data_valid;
input signed [15:0] data;
output [31:0] fft_d0,fft_d1,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,fft_d7, 
              fft_d8,fft_d9,fft_d10,fft_d11,fft_d12,fft_d13,fft_d14,fft_d15;
output fft_valid;
output done;                      
output [3:0] freq;

wire [31:0] fft_d0,fft_d1,fft_d2,fft_d3,fft_d4,fft_d5,fft_d6,fft_d7, 
              fft_d8,fft_d9,fft_d10,fft_d11,fft_d12,fft_d13,fft_d14,fft_d15;
wire fft_valid;
reg done;
wire [3:0]freq;

reg signed[31:0]data_duff[159:0];
wire signed[31:0]data_duff_temp0,stage1_real_temp0,stage1_image_temp0;
wire signed[31:0]data_duff_temp1,stage1_real_temp1,stage1_image_temp1;
wire signed[31:0]data_duff_temp2,stage1_real_temp2,stage1_image_temp2;
wire signed[31:0]data_duff_temp3,stage1_real_temp3,stage1_image_temp3;
wire signed[31:0]data_duff_temp4,stage1_real_temp4,stage1_image_temp4;
wire signed[31:0]data_duff_temp5,stage1_real_temp5,stage1_image_temp5;
wire signed[31:0]data_duff_temp6,stage1_real_temp6,stage1_image_temp6;
wire signed[31:0]data_duff_temp7,stage1_real_temp7,stage1_image_temp7;
wire signed[31:0]data_duff_temp8,stage1_real_temp8,stage1_image_temp8;
wire signed[31:0]data_duff_temp9,stage1_real_temp9,stage1_image_temp9;
wire signed[31:0]data_duff_temp10,stage1_real_temp10,stage1_image_temp10;
wire signed[31:0]data_duff_temp11,stage1_real_temp11,stage1_image_temp11;
wire signed[31:0]data_duff_temp12,stage1_real_temp12,stage1_image_temp12;
wire signed[31:0]data_duff_temp13,stage1_real_temp13,stage1_image_temp13;
wire signed[31:0]data_duff_temp14,stage1_real_temp14,stage1_image_temp14;
wire signed[31:0]data_duff_temp15,stage1_real_temp15,stage1_image_temp15;
reg [9:0]data_cnt;

reg [9:0]stage1_data_cnt;
reg signed [31:0]stage1_data_real[159:0];
reg signed [31:0]stage1_data_image[159:0];

reg [9:0]stage2_data_cnt;
reg signed [31:0]stage2_data_real[159:0];
reg signed [31:0]stage2_data_image[159:0];

reg [9:0]stage3_data_cnt;
reg signed [31:0]stage3_data_real[159:0];
reg signed [31:0]stage3_data_image[159:0];

reg [9:0]stage4_data_cnt;
reg signed [31:0]stage4_data_real[159:0];
reg signed [31:0]stage4_data_image[159:0];

reg [9:0]combine_data_cnt;
wire signed [31:0]real_data_temp;
wire signed [31:0]image_data_temp;
wire signed [31:0]real_freq_temp;
wire signed [31:0]image_freq_temp;

reg signed [31:0]final_data[159:0];
reg [9:0]final_data_cnt;

reg  [31:0]freq_data[159:0];
wire  [31:0]freq_temp0;
wire  [31:0]freq_temp1;
wire  [31:0]freq_temp2;
wire  [31:0]freq_temp3;
wire  [31:0]freq_temp4;
wire  [31:0]freq_temp5;
wire  [31:0]freq_temp6;
wire  [31:0]freq_temp7;
wire  [31:0]freq_temp8;
wire  [31:0]freq_temp9;
wire  [31:0]freq_temp10;
wire  [31:0]freq_temp11;
wire  [31:0]freq_temp12;
wire  [31:0]freq_temp13;
wire  [31:0]freq_temp14;

integer i;

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			data_duff[i]<=0;
		end
	end	
	else begin
		if(data_valid && data_cnt <= 159)begin
			data_duff[data_cnt]<=data;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		data_cnt<=0;
	else begin
		if(data_valid && data_cnt <= 159)begin
			if(data_cnt == 159)
				data_cnt<=160;
			else
				data_cnt <= data_cnt + 1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		stage1_data_cnt<=0;
	else begin
		if(data_cnt == 160 && stage1_data_cnt <=9)begin
			if(stage1_data_cnt == 9)
				stage1_data_cnt<=10;
			else
				stage1_data_cnt <= stage1_data_cnt + 1;
		end
	end
end

assign			data_duff_temp0=data_duff[16*stage1_data_cnt];
assign			data_duff_temp1=data_duff[16*stage1_data_cnt+1];
assign			data_duff_temp2=data_duff[16*stage1_data_cnt+2];
assign			data_duff_temp3=data_duff[16*stage1_data_cnt+3];
assign			data_duff_temp4=data_duff[16*stage1_data_cnt+4];
assign			data_duff_temp5=data_duff[16*stage1_data_cnt+5];
assign			data_duff_temp6=data_duff[16*stage1_data_cnt+6];
assign			data_duff_temp7=data_duff[16*stage1_data_cnt+7];
assign			data_duff_temp8=data_duff[16*stage1_data_cnt+8];
assign			data_duff_temp9=data_duff[16*stage1_data_cnt+9];
assign			data_duff_temp10=data_duff[16*stage1_data_cnt+10];
assign			data_duff_temp11=data_duff[16*stage1_data_cnt+11];
assign			data_duff_temp12=data_duff[16*stage1_data_cnt+12];
assign			data_duff_temp13=data_duff[16*stage1_data_cnt+13];
assign			data_duff_temp14=data_duff[16*stage1_data_cnt+14];
assign			data_duff_temp15=data_duff[16*stage1_data_cnt+15];					

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage1_data_real[i]<=0;
		end
	end
	else begin
		if(data_cnt == 160 && stage1_data_cnt <=10)begin
			stage1_data_real[16*stage1_data_cnt]   <=(data_duff_temp0 + data_duff_temp8);
			stage1_data_real[16*stage1_data_cnt+1] <=(data_duff_temp1 + data_duff_temp9);
			stage1_data_real[16*stage1_data_cnt+2] <=(data_duff_temp2 + data_duff_temp10);
			stage1_data_real[16*stage1_data_cnt+3] <=(data_duff_temp3 + data_duff_temp11);
			stage1_data_real[16*stage1_data_cnt+4] <=(data_duff_temp4 + data_duff_temp12);
			stage1_data_real[16*stage1_data_cnt+5] <=(data_duff_temp5 + data_duff_temp13);
			stage1_data_real[16*stage1_data_cnt+6] <=(data_duff_temp6 + data_duff_temp14);
			stage1_data_real[16*stage1_data_cnt+7] <=(data_duff_temp7 + data_duff_temp15);
			
			stage1_data_real[16*stage1_data_cnt+8] <=((data_duff_temp0 - data_duff_temp8))*$signed(32'h00010000);
			stage1_data_real[16*stage1_data_cnt+9] <=((data_duff_temp1 - data_duff_temp9))*$signed(32'h0000EC83);
			stage1_data_real[16*stage1_data_cnt+10]<=((data_duff_temp2 - data_duff_temp10))*$signed(32'h0000B504);
			stage1_data_real[16*stage1_data_cnt+11]<=((data_duff_temp3 - data_duff_temp11))*$signed(32'h000061F7);
			stage1_data_real[16*stage1_data_cnt+12]<=((data_duff_temp4 - data_duff_temp12))*$signed(32'h00000000);
			stage1_data_real[16*stage1_data_cnt+13]<=((data_duff_temp5 - data_duff_temp13))*$signed(32'hFFFF9E09);
			stage1_data_real[16*stage1_data_cnt+14]<=((data_duff_temp6 - data_duff_temp14))*$signed(32'hFFFF4AFC);
			stage1_data_real[16*stage1_data_cnt+15]<=((data_duff_temp7 - data_duff_temp15))*$signed(32'hFFFF137D);
		end
	end
end
		
always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage1_data_image[i]<=0;
		end
	end
	else begin
		if(data_cnt == 160 && stage1_data_cnt <=9)begin
			stage1_data_image[16*stage1_data_cnt]   <=0;
			stage1_data_image[16*stage1_data_cnt+1] <=0;
			stage1_data_image[16*stage1_data_cnt+2] <=0;
			stage1_data_image[16*stage1_data_cnt+3] <=0;
			stage1_data_image[16*stage1_data_cnt+4] <=0;
			stage1_data_image[16*stage1_data_cnt+5] <=0;
			stage1_data_image[16*stage1_data_cnt+6] <=0;
			stage1_data_image[16*stage1_data_cnt+7] <=0;
			
			stage1_data_image[16*stage1_data_cnt+8] <=(data_duff_temp0 - data_duff_temp8)*32'h00000000;
			stage1_data_image[16*stage1_data_cnt+9] <=(data_duff_temp1 - data_duff_temp9)*32'hFFFF9E09;
			stage1_data_image[16*stage1_data_cnt+10]<=(data_duff_temp2 - data_duff_temp10)*32'hFFFF4AFC;
			stage1_data_image[16*stage1_data_cnt+11]<=(data_duff_temp3 - data_duff_temp11)*32'hFFFF137D;
			stage1_data_image[16*stage1_data_cnt+12]<=(data_duff_temp4 - data_duff_temp12)*32'hFFFF0000;
			stage1_data_image[16*stage1_data_cnt+13]<=(data_duff_temp5 - data_duff_temp13)*32'hFFFF137D;
			stage1_data_image[16*stage1_data_cnt+14]<=(data_duff_temp6 - data_duff_temp14)*32'hFFFF4AFC;
			stage1_data_image[16*stage1_data_cnt+15]<=(data_duff_temp7 - data_duff_temp15)*32'hFFFF9E09;			
		end
	end
end

assign			stage1_real_temp0=stage1_data_real[16*stage2_data_cnt];
assign			stage1_real_temp1=stage1_data_real[16*stage2_data_cnt+1];
assign			stage1_real_temp2=stage1_data_real[16*stage2_data_cnt+2];
assign			stage1_real_temp3=stage1_data_real[16*stage2_data_cnt+3];
assign			stage1_real_temp4=stage1_data_real[16*stage2_data_cnt+4];
assign			stage1_real_temp5=stage1_data_real[16*stage2_data_cnt+5];
assign			stage1_real_temp6=stage1_data_real[16*stage2_data_cnt+6];
assign			stage1_real_temp7=stage1_data_real[16*stage2_data_cnt+7];
assign			stage1_real_temp8=stage1_data_real[16*stage2_data_cnt+8];
assign			stage1_real_temp9=stage1_data_real[16*stage2_data_cnt+9];
assign			stage1_real_temp10=stage1_data_real[16*stage2_data_cnt+10];
assign			stage1_real_temp11=stage1_data_real[16*stage2_data_cnt+11];
assign			stage1_real_temp12=stage1_data_real[16*stage2_data_cnt+12];
assign			stage1_real_temp13=stage1_data_real[16*stage2_data_cnt+13];
assign			stage1_real_temp14=stage1_data_real[16*stage2_data_cnt+14];
assign			stage1_real_temp15=stage1_data_real[16*stage2_data_cnt+15];

assign			stage1_image_temp0=stage1_data_image[16*stage2_data_cnt];
assign			stage1_image_temp1=stage1_data_image[16*stage2_data_cnt+1];
assign			stage1_image_temp2=stage1_data_image[16*stage2_data_cnt+2];
assign			stage1_image_temp3=stage1_data_image[16*stage2_data_cnt+3];
assign			stage1_image_temp4=stage1_data_image[16*stage2_data_cnt+4];
assign			stage1_image_temp5=stage1_data_image[16*stage2_data_cnt+5];
assign			stage1_image_temp6=stage1_data_image[16*stage2_data_cnt+6];
assign			stage1_image_temp7=stage1_data_image[16*stage2_data_cnt+7];
assign			stage1_image_temp8=stage1_data_image[16*stage2_data_cnt+8];
assign			stage1_image_temp9=stage1_data_image[16*stage2_data_cnt+9];
assign			stage1_image_temp10=stage1_data_image[16*stage2_data_cnt+10];
assign			stage1_image_temp11=stage1_data_image[16*stage2_data_cnt+11];
assign			stage1_image_temp12=stage1_data_image[16*stage2_data_cnt+12];
assign			stage1_image_temp13=stage1_data_image[16*stage2_data_cnt+13];
assign			stage1_image_temp14=stage1_data_image[16*stage2_data_cnt+14];
assign			stage1_image_temp15=stage1_data_image[16*stage2_data_cnt+15];		

always@(posedge clk or posedge rst)begin
	if(rst)
		stage2_data_cnt<=0;
	else begin
		if(stage1_data_cnt == 10 && stage2_data_cnt <=9)begin
			if(stage2_data_cnt == 9)
				stage2_data_cnt<=10;
			else
				stage2_data_cnt <= stage2_data_cnt + 1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage2_data_real[i]<=0;
		end
	end
	else begin
		if(stage1_data_cnt ==10 && stage2_data_cnt <= 9)begin
			stage2_data_real[16*stage2_data_cnt   ] <=  stage1_real_temp0 + stage1_real_temp4;
			stage2_data_real[16*stage2_data_cnt+1 ] <=  stage1_real_temp1 + stage1_real_temp5;
			stage2_data_real[16*stage2_data_cnt+2 ] <=  stage1_real_temp2 + stage1_real_temp6;
			stage2_data_real[16*stage2_data_cnt+3 ] <=  stage1_real_temp3 + stage1_real_temp7;
			stage2_data_real[16*stage2_data_cnt+8 ] <=  (stage1_real_temp8 >>>16) + (stage1_real_temp12 >>>16);
			stage2_data_real[16*stage2_data_cnt+9 ] <=  (stage1_real_temp9 >>>16) + (stage1_real_temp13 >>>16);
			stage2_data_real[16*stage2_data_cnt+10] <=  (stage1_real_temp10 >>>16) + (stage1_real_temp14 >>>16);
			stage2_data_real[16*stage2_data_cnt+11] <=  (stage1_real_temp11 >>>16) + (stage1_real_temp15 >>>16);
			
			stage2_data_real[16*stage2_data_cnt+4 ] <= (stage1_real_temp0-stage1_real_temp4)*$signed(32'h00010000) + (stage1_image_temp4-stage1_image_temp0)*$signed(32'h00000000);   
			stage2_data_real[16*stage2_data_cnt+5 ] <= (stage1_real_temp1-stage1_real_temp5)*$signed(32'h0000B504) + (stage1_image_temp5-stage1_image_temp1)*$signed(32'hFFFF4AFC);   
			stage2_data_real[16*stage2_data_cnt+6 ] <= (stage1_real_temp2-stage1_real_temp6)*$signed(32'h00000000) + (stage1_image_temp6-stage1_image_temp2)*$signed(32'hFFFF0000);   
			stage2_data_real[16*stage2_data_cnt+7 ] <= (stage1_real_temp3-stage1_real_temp7)*$signed(32'hFFFF4AFC) + (stage1_image_temp7-stage1_image_temp3)*$signed(32'hFFFF4AFC);   
			stage2_data_real[16*stage2_data_cnt+12] <= ((stage1_real_temp8 >>>16)  - (stage1_real_temp12 >>>16))*$signed(32'h00010000) + ((stage1_image_temp12>>>16) - (stage1_image_temp8>>>16 ))*$signed(32'h00000000);   
			stage2_data_real[16*stage2_data_cnt+13] <= ((stage1_real_temp9 >>>16)  - (stage1_real_temp13 >>>16))*$signed(32'h0000B504) + ((stage1_image_temp13>>>16) - (stage1_image_temp9>>>16 ))*$signed(32'hFFFF4AFC);   
			stage2_data_real[16*stage2_data_cnt+14] <= ((stage1_real_temp10 >>>16) - (stage1_real_temp14 >>>16))*$signed(32'h00000000) + ((stage1_image_temp14>>>16) - (stage1_image_temp10>>>16))*$signed(32'hFFFF0000);   
			stage2_data_real[16*stage2_data_cnt+15] <= ((stage1_real_temp11 >>>16) - (stage1_real_temp15 >>>16))*$signed(32'hFFFF4AFC) + ((stage1_image_temp15>>>16) - (stage1_image_temp11>>>16))*$signed(32'hFFFF4AFC);   
		end		
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage2_data_image[i]<=0;
		end
	end
	else begin
		if(stage1_data_cnt ==10 && stage2_data_cnt <= 9)begin
			stage2_data_image[16*stage2_data_cnt   ] <=  stage1_data_image[16*stage2_data_cnt   ] + stage1_data_image[16*stage2_data_cnt+4];
			stage2_data_image[16*stage2_data_cnt+1 ] <=  stage1_data_image[16*stage2_data_cnt+ 1] + stage1_data_image[16*stage2_data_cnt+5];
			stage2_data_image[16*stage2_data_cnt+2 ] <=  stage1_data_image[16*stage2_data_cnt+ 2] + stage1_data_image[16*stage2_data_cnt+6];
			stage2_data_image[16*stage2_data_cnt+3 ] <=  stage1_data_image[16*stage2_data_cnt+ 3] + stage1_data_image[16*stage2_data_cnt+7];
			stage2_data_image[16*stage2_data_cnt+8 ] <=  stage1_data_image[16*stage2_data_cnt+ 8] + stage1_data_image[16*stage2_data_cnt+12];
			stage2_data_image[16*stage2_data_cnt+9 ] <=  stage1_data_image[16*stage2_data_cnt+ 9] + stage1_data_image[16*stage2_data_cnt+13];
			stage2_data_image[16*stage2_data_cnt+10] <=  stage1_data_image[16*stage2_data_cnt+10] + stage1_data_image[16*stage2_data_cnt+14];
			stage2_data_image[16*stage2_data_cnt+11] <=  stage1_data_image[16*stage2_data_cnt+11] + stage1_data_image[16*stage2_data_cnt+15];
			
			stage2_data_image[16*stage2_data_cnt+4 ] <= (stage1_data_real[16*stage2_data_cnt   ]-stage1_data_real[16*stage2_data_cnt+ 4])*$signed(32'h00000000) + (-stage1_data_image[16*stage2_data_cnt+ 4]+stage1_data_image[16*stage2_data_cnt  ])*$signed(32'h00010000);   
			stage2_data_image[16*stage2_data_cnt+5 ] <= (stage1_data_real[16*stage2_data_cnt+ 1]-stage1_data_real[16*stage2_data_cnt+ 5])*$signed(32'hFFFF4AFC) + (-stage1_data_image[16*stage2_data_cnt+ 5]+stage1_data_image[16*stage2_data_cnt+1])*$signed(32'h0000B504);   
			stage2_data_image[16*stage2_data_cnt+6 ] <= (stage1_data_real[16*stage2_data_cnt+ 2]-stage1_data_real[16*stage2_data_cnt+ 6])*$signed(32'hFFFF0000) + (-stage1_data_image[16*stage2_data_cnt+ 6]+stage1_data_image[16*stage2_data_cnt+2])*$signed(32'h00000000);   
			stage2_data_image[16*stage2_data_cnt+7 ] <= (stage1_data_real[16*stage2_data_cnt+ 3]-stage1_data_real[16*stage2_data_cnt+ 7])*$signed(32'hFFFF4AFC) + (-stage1_data_image[16*stage2_data_cnt+ 7]+stage1_data_image[16*stage2_data_cnt+3])*$signed(32'hFFFF4AFC);   
			stage2_data_image[16*stage2_data_cnt+12] <= ((stage1_data_real[16*stage2_data_cnt+ 8]>>>16)-(stage1_data_real[16*stage2_data_cnt+12]>>>16))*$signed(32'h00000000) + ((stage1_data_image[16*stage2_data_cnt+ 8]>>>16)-(stage1_data_image[16*stage2_data_cnt+12]>>>16))*$signed(32'h00010000);   
			stage2_data_image[16*stage2_data_cnt+13] <= ((stage1_data_real[16*stage2_data_cnt+ 9]>>>16)-(stage1_data_real[16*stage2_data_cnt+13]>>>16))*$signed(32'hFFFF4AFC) + ((stage1_data_image[16*stage2_data_cnt+ 9]>>>16)-(stage1_data_image[16*stage2_data_cnt+13]>>>16))*$signed(32'h0000B504);   
			stage2_data_image[16*stage2_data_cnt+14] <= ((stage1_data_real[16*stage2_data_cnt+10]>>>16)-(stage1_data_real[16*stage2_data_cnt+14]>>>16))*$signed(32'hFFFF0000) + ((stage1_data_image[16*stage2_data_cnt+10]>>>16)-(stage1_data_image[16*stage2_data_cnt+14]>>>16))*$signed(32'h00000000);   
			stage2_data_image[16*stage2_data_cnt+15] <= ((stage1_data_real[16*stage2_data_cnt+11]>>>16)-(stage1_data_real[16*stage2_data_cnt+15]>>>16))*$signed(32'hFFFF4AFC) + ((stage1_data_image[16*stage2_data_cnt+11]>>>16)-(stage1_data_image[16*stage2_data_cnt+15]>>>16))*$signed(32'hFFFF4AFC);   
		end		
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		stage3_data_cnt<=0;
	else begin
		if(stage2_data_cnt == 10 && stage3_data_cnt <=9)begin
			if(stage3_data_cnt == 9)
				stage3_data_cnt<=10;
			else
				stage3_data_cnt <= stage3_data_cnt + 1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage3_data_real[i]<=0;
		end
	end
	else begin
		if(stage2_data_cnt == 10 && stage3_data_cnt <=9)begin
			stage3_data_real[16*stage3_data_cnt]    <=  stage2_data_real[16*stage3_data_cnt]    + stage2_data_real[16*stage3_data_cnt+2];
			stage3_data_real[16*stage3_data_cnt+1]  <=  stage2_data_real[16*stage3_data_cnt+1]  + stage2_data_real[16*stage3_data_cnt+3];
			stage3_data_real[16*stage3_data_cnt+4]  <= (stage2_data_real[16*stage3_data_cnt+4]>>>16)  + (stage2_data_real[16*stage3_data_cnt+6]>>>16);
			stage3_data_real[16*stage3_data_cnt+5]  <= (stage2_data_real[16*stage3_data_cnt+5]>>>16)  + (stage2_data_real[16*stage3_data_cnt+7]>>>16);
			stage3_data_real[16*stage3_data_cnt+8]  <=  stage2_data_real[16*stage3_data_cnt+8]  + stage2_data_real[16*stage3_data_cnt+10];
			stage3_data_real[16*stage3_data_cnt+9]  <=  stage2_data_real[16*stage3_data_cnt+9]  + stage2_data_real[16*stage3_data_cnt+11];
			stage3_data_real[16*stage3_data_cnt+12] <= (stage2_data_real[16*stage3_data_cnt+12]>>>16) + (stage2_data_real[16*stage3_data_cnt+14]>>>16);
			stage3_data_real[16*stage3_data_cnt+13] <= (stage2_data_real[16*stage3_data_cnt+13]>>>16) + (stage2_data_real[16*stage3_data_cnt+15]>>>16);
			
			stage3_data_real[16*stage3_data_cnt+2]  <= (stage2_data_real[16*stage3_data_cnt]    - stage2_data_real[16*stage3_data_cnt+2])*$signed(32'h00010000)  + (-stage2_data_image[16*stage3_data_cnt]    + stage2_data_image[16*stage3_data_cnt+2])*$signed(32'h00000000);
			stage3_data_real[16*stage3_data_cnt+3]  <= (stage2_data_real[16*stage3_data_cnt+1]  - stage2_data_real[16*stage3_data_cnt+3])*$signed(32'h00000000)  + (-stage2_data_image[16*stage3_data_cnt+1]  + stage2_data_image[16*stage3_data_cnt+3])*$signed(32'hFFFF0000);
			stage3_data_real[16*stage3_data_cnt+6]  <= ((stage2_data_real[16*stage3_data_cnt+4]>>>16)  - (stage2_data_real[16*stage3_data_cnt+6]>>>16))*$signed(32'h00010000)  + (-(stage2_data_image[16*stage3_data_cnt+4]>>>16)  + (stage2_data_image[16*stage3_data_cnt+6]>>>16))*$signed(32'h00000000);
			stage3_data_real[16*stage3_data_cnt+7]  <= ((stage2_data_real[16*stage3_data_cnt+5]>>>16)  - (stage2_data_real[16*stage3_data_cnt+7]>>>16))*$signed(32'h00000000)  + (-(stage2_data_image[16*stage3_data_cnt+5]>>>16)  + (stage2_data_image[16*stage3_data_cnt+7]>>>16))*$signed(32'hFFFF0000);
			stage3_data_real[16*stage3_data_cnt+10] <= (stage2_data_real[16*stage3_data_cnt+8]  - stage2_data_real[16*stage3_data_cnt+10])*$signed(32'h00010000) + ( (stage2_data_image[16*stage3_data_cnt+10]>>>16)  - (stage2_data_image[16*stage3_data_cnt+8]>>>16))*$signed(32'h00000000);
			stage3_data_real[16*stage3_data_cnt+11] <= (stage2_data_real[16*stage3_data_cnt+9]  - stage2_data_real[16*stage3_data_cnt+11])*$signed(32'h00000000) + ( (stage2_data_image[16*stage3_data_cnt+11]>>>16)  - (stage2_data_image[16*stage3_data_cnt+9]>>>16))*$signed(32'hFFFF0000);
			stage3_data_real[16*stage3_data_cnt+14] <= ((stage2_data_real[16*stage3_data_cnt+12]>>>16) - (stage2_data_real[16*stage3_data_cnt+14]>>>16))*$signed(32'h00010000) + (-(stage2_data_image[16*stage3_data_cnt+12]>>>16) + (stage2_data_image[16*stage3_data_cnt+14]>>>16))*$signed(32'h00000000);
			stage3_data_real[16*stage3_data_cnt+15] <= ((stage2_data_real[16*stage3_data_cnt+13]>>>16) - (stage2_data_real[16*stage3_data_cnt+15]>>>16))*$signed(32'h00000000) + (-(stage2_data_image[16*stage3_data_cnt+13]>>>16) + (stage2_data_image[16*stage3_data_cnt+15]>>>16))*$signed(32'hFFFF0000);
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage3_data_image[i]<=0;
		end
	end
	else begin
		if(stage2_data_cnt == 10 && stage3_data_cnt <=9)begin
			stage3_data_image[16*stage3_data_cnt] <= stage2_data_image[16*stage3_data_cnt] + stage2_data_image[16*stage3_data_cnt+2];
			stage3_data_image[16*stage3_data_cnt+1] <= stage2_data_image[16*stage3_data_cnt+1] + stage2_data_image[16*stage3_data_cnt+3];
			stage3_data_image[16*stage3_data_cnt+4] <= stage2_data_image[16*stage3_data_cnt+4] + (stage2_data_image[16*stage3_data_cnt+6]>>>16);
			stage3_data_image[16*stage3_data_cnt+5] <= (stage2_data_image[16*stage3_data_cnt+5]>>>16) + (stage2_data_image[16*stage3_data_cnt+7]>>>16);
			stage3_data_image[16*stage3_data_cnt+8] <= (stage2_data_image[16*stage3_data_cnt+8]>>>16) + (stage2_data_image[16*stage3_data_cnt+10]>>>16);
			stage3_data_image[16*stage3_data_cnt+9] <= (stage2_data_image[16*stage3_data_cnt+9]>>>16) + (stage2_data_image[16*stage3_data_cnt+11]>>>16);
			stage3_data_image[16*stage3_data_cnt+12] <= (stage2_data_image[16*stage3_data_cnt+12]>>>16) + (stage2_data_image[16*stage3_data_cnt+14]>>>16);
			stage3_data_image[16*stage3_data_cnt+13] <= (stage2_data_image[16*stage3_data_cnt+13]>>>16) + (stage2_data_image[16*stage3_data_cnt+15]>>>16);
			
			stage3_data_image[16*stage3_data_cnt+2] <= (stage2_data_real[16*stage3_data_cnt] - stage2_data_real[16*stage3_data_cnt+2])*$signed(32'h00000000) + (stage2_data_image[16*stage3_data_cnt] - stage2_data_image[16*stage3_data_cnt+2])*$signed(32'h00010000);
			stage3_data_image[16*stage3_data_cnt+3] <= (stage2_data_real[16*stage3_data_cnt+1] - stage2_data_real[16*stage3_data_cnt+3])*$signed(32'hFFFF0000) + (stage2_data_image[16*stage3_data_cnt+1] - stage2_data_image[16*stage3_data_cnt+3])*$signed(32'h00000000);
			stage3_data_image[16*stage3_data_cnt+6] <= ((stage2_data_real[16*stage3_data_cnt+4]>>>16) - (stage2_data_real[16*stage3_data_cnt+6]>>>16))*$signed(32'h00000000) + (stage2_data_image[16*stage3_data_cnt+4] - (stage2_data_image[16*stage3_data_cnt+6]>>>16))*$signed(32'h00010000);
			stage3_data_image[16*stage3_data_cnt+7] <= ((stage2_data_real[16*stage3_data_cnt+5]>>>16) - (stage2_data_real[16*stage3_data_cnt+7]>>>16))*$signed(32'hFFFF0000) + ((stage2_data_image[16*stage3_data_cnt+5]>>>16) - (stage2_data_image[16*stage3_data_cnt+7]>>>16))*$signed(32'h00000000);
			stage3_data_image[16*stage3_data_cnt+10] <= (stage2_data_real[16*stage3_data_cnt+8] - stage2_data_real[16*stage3_data_cnt+10])*$signed(32'h00000000) + ((stage2_data_image[16*stage3_data_cnt+8]>>>16) - (stage2_data_image[16*stage3_data_cnt+10]>>>16))*$signed(32'h00010000);
			stage3_data_image[16*stage3_data_cnt+11] <= (stage2_data_real[16*stage3_data_cnt+9] - stage2_data_real[16*stage3_data_cnt+11])*$signed(32'hFFFF0000) + ((stage2_data_image[16*stage3_data_cnt+9]>>>16) - (stage2_data_image[16*stage3_data_cnt+11]>>>16))*$signed(32'h00000000);
			stage3_data_image[16*stage3_data_cnt+14] <= ((stage2_data_real[16*stage3_data_cnt+12]>>>16) - (stage2_data_real[16*stage3_data_cnt+14]>>>16))*$signed(32'h00000000) + ((stage2_data_image[16*stage3_data_cnt+12]>>>16) - (stage2_data_image[16*stage3_data_cnt+14]>>>16))*$signed(32'h00010000);
			stage3_data_image[16*stage3_data_cnt+15] <= ((stage2_data_real[16*stage3_data_cnt+13]>>>16) - (stage2_data_real[16*stage3_data_cnt+15]>>>16))*$signed(32'hFFFF0000) + ((stage2_data_image[16*stage3_data_cnt+13]>>>16) - (stage2_data_image[16*stage3_data_cnt+15]>>>16))*$signed(32'h00000000);
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		stage4_data_cnt<=0;
	else begin
		if(stage3_data_cnt == 10 && stage4_data_cnt <=9)begin
			if(stage4_data_cnt == 9)
				stage4_data_cnt<=10;
			else
				stage4_data_cnt <= stage4_data_cnt + 1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage4_data_real[i]<=0;
		end
	end
	else begin
		if(stage3_data_cnt == 10 && stage4_data_cnt <=9)begin
			stage4_data_real[16*stage4_data_cnt] <= stage3_data_real[16*stage4_data_cnt] + stage3_data_real[16*stage4_data_cnt+1];
			stage4_data_real[16*stage4_data_cnt+2] <= (stage3_data_real[16*stage4_data_cnt+2]>>>16) + (stage3_data_real[16*stage4_data_cnt+3]>>>16);
			stage4_data_real[16*stage4_data_cnt+4] <= stage3_data_real[16*stage4_data_cnt+4] + stage3_data_real[16*stage4_data_cnt+5];
			stage4_data_real[16*stage4_data_cnt+6] <= (stage3_data_real[16*stage4_data_cnt+6]>>>16) + (stage3_data_real[16*stage4_data_cnt+7]>>>16);
			stage4_data_real[16*stage4_data_cnt+8] <= stage3_data_real[16*stage4_data_cnt+8] + stage3_data_real[16*stage4_data_cnt+9];
			stage4_data_real[16*stage4_data_cnt+10] <= (stage3_data_real[16*stage4_data_cnt+10]>>>16) + (stage3_data_real[16*stage4_data_cnt+11]>>>16);
			stage4_data_real[16*stage4_data_cnt+12] <= stage3_data_real[16*stage4_data_cnt+12] + stage3_data_real[16*stage4_data_cnt+13];
			stage4_data_real[16*stage4_data_cnt+14] <= (stage3_data_real[16*stage4_data_cnt+14]>>>16) + (stage3_data_real[16*stage4_data_cnt+15]>>>16);
			
			stage4_data_real[16*stage4_data_cnt+1] <= (stage3_data_real[16*stage4_data_cnt] - stage3_data_real[16*stage4_data_cnt+1])*$signed(32'h00010000) + (-stage3_data_image[16*stage4_data_cnt] + stage3_data_image[16*stage4_data_cnt+1])*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+3] <= ((stage3_data_real[16*stage4_data_cnt+2]>>>16) - (stage3_data_real[16*stage4_data_cnt+3]>>>16))*$signed(32'h00010000) + ((stage3_data_image[16*stage4_data_cnt+3]>>>16) - (stage3_data_image[16*stage4_data_cnt+2]>>>16))*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+5] <= (stage3_data_real[16*stage4_data_cnt+4] - stage3_data_real[16*stage4_data_cnt+5])*$signed(32'h00010000) + (-stage3_data_image[16*stage4_data_cnt+4] + stage3_data_image[16*stage4_data_cnt+5])*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+7] <= ((stage3_data_real[16*stage4_data_cnt+6]>>>16) - (stage3_data_real[16*stage4_data_cnt+7]>>>16))*$signed(32'h00010000) + ((stage3_data_image[16*stage4_data_cnt+7]>>>16) - (stage3_data_image[16*stage4_data_cnt+6]>>>16))*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+9] <= (stage3_data_real[16*stage4_data_cnt+8] - stage3_data_real[16*stage4_data_cnt+9])*$signed(32'h00010000) + (-stage3_data_image[16*stage4_data_cnt+8] + stage3_data_image[16*stage4_data_cnt+9])*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+11] <= ((stage3_data_real[16*stage4_data_cnt+10]>>>16) - (stage3_data_real[16*stage4_data_cnt+11]>>>16))*$signed(32'h00010000) + ((stage3_data_image[16*stage4_data_cnt+11]>>>16) - (stage3_data_image[16*stage4_data_cnt+10]>>>16))*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+13] <= (stage3_data_real[16*stage4_data_cnt+12] - stage3_data_real[16*stage4_data_cnt+13])*$signed(32'h00010000) + (-stage3_data_image[16*stage4_data_cnt+12] + stage3_data_image[16*stage4_data_cnt+13])*$signed(32'h00000000);
			stage4_data_real[16*stage4_data_cnt+15] <= ((stage3_data_real[16*stage4_data_cnt+14]>>>16) - (stage3_data_real[16*stage4_data_cnt+15]>>>16))*$signed(32'h00010000) + ((stage3_data_image[16*stage4_data_cnt+15]>>>16) - (stage3_data_image[16*stage4_data_cnt+14]>>>16))*$signed(32'h00000000);
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			stage4_data_image[i]<=0;
		end
	end
	else begin
		if(stage3_data_cnt == 10 && stage4_data_cnt <=9)begin
			stage4_data_image[16*stage4_data_cnt] <= stage3_data_image[16*stage4_data_cnt] + stage3_data_image[16*stage4_data_cnt+1];
			stage4_data_image[16*stage4_data_cnt+2] <= (stage3_data_image[16*stage4_data_cnt+2]>>>16) + (stage3_data_image[16*stage4_data_cnt+3]>>>16);
			stage4_data_image[16*stage4_data_cnt+4] <= stage3_data_image[16*stage4_data_cnt+4] + stage3_data_image[16*stage4_data_cnt+5];
			stage4_data_image[16*stage4_data_cnt+6] <= (stage3_data_image[16*stage4_data_cnt+6]>>>16) + (stage3_data_image[16*stage4_data_cnt+7]>>>16);
			stage4_data_image[16*stage4_data_cnt+8] <= stage3_data_image[16*stage4_data_cnt+8] + stage3_data_image[16*stage4_data_cnt+9];
			stage4_data_image[16*stage4_data_cnt+10] <= (stage3_data_image[16*stage4_data_cnt+10]>>>16) + (stage3_data_image[16*stage4_data_cnt+11]>>>16);
			stage4_data_image[16*stage4_data_cnt+12] <= stage3_data_image[16*stage4_data_cnt+12] + stage3_data_image[16*stage4_data_cnt+13];
			stage4_data_image[16*stage4_data_cnt+14] <= (stage3_data_image[16*stage4_data_cnt+14]>>>16) + (stage3_data_image[16*stage4_data_cnt+15]>>>16);
			
			stage4_data_image[16*stage4_data_cnt+1] <= (stage3_data_real[16*stage4_data_cnt  ] - stage3_data_real[16*stage4_data_cnt+1])*$signed(32'h00000000) + (stage3_data_image[16*stage4_data_cnt  ] - stage3_data_image[16*stage4_data_cnt+1])*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+3] <= ((stage3_data_real[16*stage4_data_cnt+2]>>>16) - (stage3_data_real[16*stage4_data_cnt+3]>>>16))*$signed(32'h00000000) + ((stage3_data_image[16*stage4_data_cnt+2]>>>16) - (stage3_data_image[16*stage4_data_cnt+3]>>>16))*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+5] <= (stage3_data_real[16*stage4_data_cnt+4] - stage3_data_real[16*stage4_data_cnt+5])*$signed(32'h00000000) + (stage3_data_image[16*stage4_data_cnt+4] - stage3_data_image[16*stage4_data_cnt+5])*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+7] <= ((stage3_data_real[16*stage4_data_cnt+6]>>>16) - (stage3_data_real[16*stage4_data_cnt+7]>>>16))*$signed(32'h00000000) + ((stage3_data_image[16*stage4_data_cnt+6]>>>16) - (stage3_data_image[16*stage4_data_cnt+7]>>>16))*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+9] <= (stage3_data_real[16*stage4_data_cnt+8] - stage3_data_real[16*stage4_data_cnt+9])*$signed(32'h00000000) + (stage3_data_image[16*stage4_data_cnt+8] - stage3_data_image[16*stage4_data_cnt+9])*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+11] <= ((stage3_data_real[16*stage4_data_cnt+10]>>>16) - (stage3_data_real[16*stage4_data_cnt+11]>>>16))*$signed(32'h00000000) + ((stage3_data_image[16*stage4_data_cnt+10]>>>16) - (stage3_data_image[16*stage4_data_cnt+11]>>>16))*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+13] <= (stage3_data_real[16*stage4_data_cnt+12] - stage3_data_real[16*stage4_data_cnt+13])*$signed(32'h00000000) + (stage3_data_image[16*stage4_data_cnt+12] - stage3_data_image[16*stage4_data_cnt+13])*$signed(32'h00010000);
			stage4_data_image[16*stage4_data_cnt+15] <= ((stage3_data_real[16*stage4_data_cnt+14]>>>16) - (stage3_data_real[16*stage4_data_cnt+15]>>>16))*$signed(32'h00000000) + ((stage3_data_image[16*stage4_data_cnt+14]>>>16) - (stage3_data_image[16*stage4_data_cnt+15]>>>16))*$signed(32'h00010000);
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		combine_data_cnt <= 0;
	else begin
		if(stage4_data_cnt == 10 && combine_data_cnt <=159)begin
			if(combine_data_cnt == 159)
				combine_data_cnt<=160;
			else
				combine_data_cnt<=combine_data_cnt+1;
		end
	end
end


assign real_data_temp  = (stage4_data_cnt == 10 && combine_data_cnt <=159) ? stage4_data_real [combine_data_cnt] : 0;
assign image_data_temp = (stage4_data_cnt == 10 && combine_data_cnt <=159) ? stage4_data_image[combine_data_cnt] : 0;
/*assign real_freq_temp =  ((real_data_temp[15])) ? 	(~real_data_temp+1) : real_data_temp;
assign image_freq_temp = (image_data_temp[15]) ? stage4_data_image[combine_data_cnt] : 0;*/

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			freq_data[i]<=0;
		end	
	end
	else begin
		if(stage4_data_cnt == 10 && combine_data_cnt <=159)begin
			if(combine_data_cnt%2 == 0)begin
				if(real_data_temp[15] && image_data_temp[15])
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[15:0]})*({16'b0,real_data_temp[15:0]})+({16'b0,image_data_temp[15:0]})*({16'b0,image_data_temp[15:0]});
				else if (real_data_temp[15])
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[15:0]})*({16'b0,real_data_temp[15:0]})+({16'b0,image_data_temp[15:0]})*({16'b0,image_data_temp[15:0]});
				else if (image_data_temp[15])
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[15:0]})*({16'b0,real_data_temp[15:0]})+({16'b0,image_data_temp[15:0]})*({16'b0,image_data_temp[15:0]});
				else
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[15:0]})*({16'b0,real_data_temp[15:0]})+({16'b0,image_data_temp[15:0]})*({16'b0,image_data_temp[15:0]});
			end
			else begin
				if(real_data_temp[31] && image_data_temp[31])
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[31:16]})*({16'b0,real_data_temp[31:16]})+({16'b0,image_data_temp[31:16]})*({16'b0,image_data_temp[31:16]});
				else if (real_data_temp[31])
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[31:16]})*({16'b0,real_data_temp[31:16]})+({16'b0,image_data_temp[31:16]})*({16'b0,image_data_temp[31:16]});
				else if (image_data_temp[31])
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[31:16]})*({16'b0,real_data_temp[31:16]})+({16'b0,image_data_temp[31:16]})*({16'b0,image_data_temp[31:16]});
				else
					freq_data[combine_data_cnt] <=({16'b0,real_data_temp[31:16]})*({16'b0,real_data_temp[31:16]})+({16'b0,image_data_temp[31:16]})*({16'b0,image_data_temp[31:16]});
			end
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<159;i=i+1)begin
			final_data[i]<=0;
		end
	end
	else begin
		if(stage4_data_cnt == 10 && combine_data_cnt <=159)begin
			if(combine_data_cnt%2 == 0)begin
				final_data[combine_data_cnt]<={real_data_temp[15:0],image_data_temp[15:0]};
			end
			else begin
				final_data[combine_data_cnt]<={real_data_temp[31:16],image_data_temp[31:16]};
			end
		end
	end
end 
		
always@(posedge clk or posedge rst)begin
	if(rst)
		final_data_cnt <= 0;
	else begin
		if(combine_data_cnt == 160 && final_data_cnt <=9)begin
			if(final_data_cnt == 9)
				final_data_cnt<=10;
			else
				final_data_cnt<=final_data_cnt+1;
		end
	end
end

assign fft_valid=	(combine_data_cnt == 160 && final_data_cnt!=10) ? 1 : 0 ;

assign fft_d0 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt]		: 0; 
assign fft_d8 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+1]	: 0; 
assign fft_d4	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+2]	: 0; 
assign fft_d12 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+3]	: 0; 
assign fft_d2 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+4]	: 0; 
assign fft_d10 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+5]	: 0; 
assign fft_d6 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+6]	: 0; 
assign fft_d14 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+7]	: 0; 
assign fft_d1 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+8]	: 0; 
assign fft_d9 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+9]	: 0; 
assign fft_d5 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+10]	: 0; 
assign fft_d13 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+11]	: 0; 
assign fft_d3 	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+12]	: 0; 
assign fft_d11	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+13]	: 0; 
assign fft_d7	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+14]	: 0; 
assign fft_d15	=	(fft_valid && combine_data_cnt == 160) ? final_data[16*final_data_cnt+15]	: 0;	
	
assign freq_temp0 = (freq_data[16*final_data_cnt] > freq_data[16*final_data_cnt+1]) ? 0 : 1;
assign freq_temp1 = (freq_data[16*final_data_cnt+2] > freq_data[16*final_data_cnt+3]) ? 2 : 3;
assign freq_temp2 = (freq_data[16*final_data_cnt+4] > freq_data[16*final_data_cnt+5]) ? 4 : 5;
assign freq_temp3 = (freq_data[16*final_data_cnt+6] > freq_data[16*final_data_cnt+7]) ? 6 : 7;
assign freq_temp4 = (freq_data[16*final_data_cnt+8] > freq_data[16*final_data_cnt+9]) ? 8 : 9;
assign freq_temp5 = (freq_data[16*final_data_cnt+10] > freq_data[16*final_data_cnt+11]) ? 10 : 11;
assign freq_temp6 = (freq_data[16*final_data_cnt+12] > freq_data[16*final_data_cnt+13]) ? 12 : 13;
assign freq_temp7 = (freq_data[16*final_data_cnt+14] > freq_data[16*final_data_cnt+15]) ? 14 : 15;

assign freq_temp8  = (freq_data[16*final_data_cnt+freq_temp0] > freq_data[16*final_data_cnt+freq_temp1]) ? freq_temp0 : freq_temp1;
assign freq_temp9  = (freq_data[16*final_data_cnt+freq_temp2] > freq_data[16*final_data_cnt+freq_temp3]) ? freq_temp2 : freq_temp3;
assign freq_temp10 = (freq_data[16*final_data_cnt+freq_temp4] > freq_data[16*final_data_cnt+freq_temp5]) ? freq_temp4 : freq_temp5;
assign freq_temp11 = (freq_data[16*final_data_cnt+freq_temp6] > freq_data[16*final_data_cnt+freq_temp7]) ? freq_temp6 : freq_temp7;

assign freq_temp12 = (freq_data[16*final_data_cnt+freq_temp8]  > freq_data[16*final_data_cnt+freq_temp9]) ? freq_temp8 : freq_temp9;
assign freq_temp13 = (freq_data[16*final_data_cnt+freq_temp10] > freq_data[16*final_data_cnt+freq_temp11]) ? freq_temp10 : freq_temp11;

assign freq_temp14 = (freq_data[16*final_data_cnt+freq_temp12] > freq_data[16*final_data_cnt+freq_temp13]) ? freq_temp12 : freq_temp13;
assign freq		   = (combine_data_cnt == 160) ? freq_temp14 : 0 ;
						

always@(posedge clk or posedge rst)begin
	if(rst)
		done<=0;
	else begin
		if(combine_data_cnt >= 159 && final_data_cnt <9)
			done <= 1;
		else	
			done <= 0;
	end
end
	
endmodule