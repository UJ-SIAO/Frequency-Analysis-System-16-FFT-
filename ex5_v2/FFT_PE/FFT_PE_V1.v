module FFT_PE(
			 clk, 
			 rst, 			 
			 a, 
			 b,
			 power,			 
			 ab_valid, 
			 fft_a, 
			 fft_b,
			 fft_pe_valid
			 );
input clk, rst; 		 
input signed [31:0] a, b;
input [2:0] power;
input ab_valid;		
output [31:0] fft_a, fft_b;
output fft_pe_valid;

wire [31:0]fft_a;
wire [31:0]fft_b;
wire fft_pe_valid;

reg [31:0]data_a[7:0];
reg [31:0]data_b[7:0];
reg [31:0]data_a_temp;
reg [31:0]data_b_temp;
reg	[4:0]data_cnt;

reg [31:0]real_a[7:0];
reg [31:0]image_a[7:0];
reg [31:0]real_b[7:0];
reg [31:0]image_b[7:0];
reg [31:0]real_a_temp;
reg [31:0]real_b_temp;
reg [31:0]image_a_temp;
reg [31:0]image_b_temp;
reg [4:0]process_data_cnt;

reg [4:0]combine_data_cnt;

integer i;
	
always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<8;i=i+1)begin
			data_a[i]<=0;
			data_b[i]<=0;
		end
	end	
	else begin
		if(ab_valid && data_cnt <= 7)begin
			data_a[data_cnt]<=a;
			data_b[data_cnt]<=b;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		data_cnt<=0;
	else begin
		if(ab_valid && data_cnt <= 7)begin
			if(data_cnt == 7)
				data_cnt<=8;
			else
				data_cnt <= data_cnt + 1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		process_data_cnt<=0;
	else begin
		if(data_cnt == 8 && process_data_cnt <=7)begin
			if(process_data_cnt == 7)
				process_data_cnt<=8;
			else
				process_data_cnt <= process_data_cnt + 1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		data_a_temp<=0;
		data_b_temp<=0;
	end
	else begin
		if(data_cnt == 8 && process_data_cnt <=7)begin
			data_a_temp<=data_a[process_data_cnt];
			data_b_temp<=data_b[process_data_cnt];
		end
	end
end

/*assign data_a_temp = (data_cnt == 8 && process_data_cnt <=7) ? data_a[process_data_cnt] : 0 ;
assign data_b_temp = (data_cnt == 8 && process_data_cnt <=7) ? data_b[process_data_cnt] : 0 ;*/

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<8;i=i+1)begin
			real_a[i]<=0;
		end
	end
	else begin
		if(data_cnt == 8 && process_data_cnt <=7)
			real_a[process_data_cnt] <= data_a_temp[31:16] + data_b_temp[31:16];
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<8;i=i+1)begin
			image_a[i]<=0;
		end
	end
	else begin
		if(data_cnt == 8 && process_data_cnt <=7)
			image_a[process_data_cnt] <= data_a_temp[15:0] + data_b_temp[15:0];
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<8;i=i+1)begin
			real_b[i]<=0;
		end
	end
	else begin
		if(data_cnt == 8 && process_data_cnt <=7)
			real_b[process_data_cnt] <= (data_a_temp[31:16] - data_b_temp[31:16] ) * 32'h00010000 + (data_b_temp[15:0] - data_a_temp[15:0]) * 32'h00000000;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		for(i=0;i<8;i=i+1)begin
			image_b[i]<=0;
		end
	end
	else begin
		if(data_cnt == 8 && process_data_cnt <=7)
			image_b[process_data_cnt] <= (data_a_temp[31:16] - data_b_temp[31:16] ) * 32'h00000000 + (data_a_temp[15:0] - data_b_temp[15:0]) * 32'h00010000;
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)
		combine_data_cnt <= 0;
	else begin
		if(process_data_cnt == 8 && combine_data_cnt <=7)begin
			if(combine_data_cnt == 7)
				combine_data_cnt<=8;
			else
				combine_data_cnt<=combine_data_cnt+1;
		end
	end
end

always@(posedge clk or posedge rst)begin
	if(rst)begin
		real_a_temp<=0;
		real_b_temp<=0;
		image_a_temp<=0;
		image_b_temp<=0;
	end
	else begin
		if(process_data_cnt == 8 && combine_data_cnt <=7)begin
			real_a_temp<=real_a[combine_data_cnt];
			real_b_temp<=real_b[combine_data_cnt];
			image_a_temp<=image_a[combine_data_cnt];
			image_b_temp<=image_b[combine_data_cnt];			
		end
	end
end
	

/*always@(posedge clk or posedge rst)begin
	if(rst)begin
		fft_a<=0;
		fft_b<=0;
	end
	else begin
		if(fft_pe_valid)begin
			if(process_data_cnt == 8)begin
				fft_a <= {real_a_temp[15:0],image_a_temp[15:0]};
				fft_b <= {real_b_temp[15:0],image_b_temp[15:0]};
			end
		end
	end
end*/
assign fft_a		=  (fft_pe_valid && process_data_cnt==8) ? {real_a_temp[15:0],image_a_temp[15:0]} : 0;
assign fft_b		=  (fft_pe_valid && process_data_cnt==8) ? {real_b_temp[31:16],image_b_temp[31:16]} : 0;

assign fft_pe_valid = (process_data_cnt == 8 && combine_data_cnt >= 2) ? 1 : 0 ;

/*always@(posedge clk or posedge rst)begin
	if(rst)
		fft_pe_valid<=0;
	else begin
		if(process_data_cnt == 8)
			fft_pe_valid <=1;
		else
			fft_pe_valid <=0;
	end
end*/

endmodule

