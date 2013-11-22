// $Id: $
// File name:   sbytes.sv
// Created:     11/18/2013
// Author:      Josh Nichols
// Lab Section: 002
// Version:     1.0  Initial Design Entry
// Description: Swap Bytes
// Explanation: Because program will run on every positive edge of sbytes_enable, enable sbytes_enable 16 times for all bytes

module sbytes
(
	input wire [7:0] olddata,
	//input wire [255:0] table,
	//input wire sbytes_enable,
	//output reg sbytes_finished,
	output reg [7:0] newdata
);

assign newdata = (olddata==0 ? 8'h63 :
                 (olddata==1 ? 8'h7c :
                 (olddata==2 ? 8'h77 :
                 (olddata==3 ? 8'h7b :
                 (olddata==4 ? 8'hf2 :
                 (olddata==5 ? 8'h6b :
                 (olddata==6 ? 8'h6f :
                 (olddata==7 ? 8'hc5 :
                 (olddata==8 ? 8'h30 :
                 (olddata==9 ? 8'h1 :
                 (olddata==10 ? 8'h67 :
                 (olddata==11 ? 8'h2b :
                 (olddata==12 ? 8'hfe :
                 (olddata==13 ? 8'hd7 :
                 (olddata==14 ? 8'hab :
                 (olddata==15 ? 8'h76 :
                 (olddata==16 ? 8'hca :
                 (olddata==17 ? 8'h82 :
                 (olddata==18 ? 8'hc9 :
                 (olddata==19 ? 8'h7d :
                 (olddata==20 ? 8'hfa :
                 (olddata==21 ? 8'h59 :
                 (olddata==22 ? 8'h47 :
                 (olddata==23 ? 8'hf0 :
                 (olddata==24 ? 8'had :
                 (olddata==25 ? 8'hd4 :
                 (olddata==26 ? 8'ha2 :
                 (olddata==27 ? 8'haf :
                 (olddata==28 ? 8'h9c :
                 (olddata==29 ? 8'ha4 :
                 (olddata==30 ? 8'h72 :
                 (olddata==31 ? 8'hc0 :
                 (olddata==32 ? 8'hb7 :
                 (olddata==33 ? 8'hfd :
                 (olddata==34 ? 8'h93 :
                 (olddata==35 ? 8'h26 :
                 (olddata==36 ? 8'h36 :
                 (olddata==37 ? 8'h3f :
                 (olddata==38 ? 8'hf7 :
                 (olddata==39 ? 8'hcc :
                 (olddata==40 ? 8'h34 :
                 (olddata==41 ? 8'ha5 :
                 (olddata==42 ? 8'he5 :
                 (olddata==43 ? 8'hf1 :
                 (olddata==44 ? 8'h71 :
                 (olddata==45 ? 8'hd8 :
                 (olddata==46 ? 8'h31 :
                 (olddata==47 ? 8'h15 :
                 (olddata==48 ? 8'h4 :
                 (olddata==49 ? 8'hc7 :
                 (olddata==50 ? 8'h23 :
                 (olddata==51 ? 8'hc3 :
                 (olddata==52 ? 8'h18 :
                 (olddata==53 ? 8'h96 :
                 (olddata==54 ? 8'h5 :
                 (olddata==55 ? 8'h9a :
                 (olddata==56 ? 8'h7 :
                 (olddata==57 ? 8'h12 :
                 (olddata==58 ? 8'h80 :
                 (olddata==59 ? 8'he2 :
                 (olddata==60 ? 8'heb :
                 (olddata==61 ? 8'h27 :
                 (olddata==62 ? 8'hb2 :
                 (olddata==63 ? 8'h75 :
                 (olddata==64 ? 8'h9 :
                 (olddata==65 ? 8'h83 :
                 (olddata==66 ? 8'h2c :
                 (olddata==67 ? 8'h1a :
                 (olddata==68 ? 8'h1b :
                 (olddata==69 ? 8'h6e :
                 (olddata==70 ? 8'h5a :
                 (olddata==71 ? 8'ha0 :
                 (olddata==72 ? 8'h52 :
                 (olddata==73 ? 8'h3b :
                 (olddata==74 ? 8'hd6 :
                 (olddata==75 ? 8'hb3 :
                 (olddata==76 ? 8'h29 :
                 (olddata==77 ? 8'he3 :
                 (olddata==78 ? 8'h2f :
                 (olddata==79 ? 8'h84 :
                 (olddata==80 ? 8'h53 :
                 (olddata==81 ? 8'hd1 :
                 (olddata==82 ? 8'h0 :
                 (olddata==83 ? 8'hed :
                 (olddata==84 ? 8'h20 :
                 (olddata==85 ? 8'hfc :
                 (olddata==86 ? 8'hb1 :
                 (olddata==87 ? 8'h5b :
                 (olddata==88 ? 8'h6a :
                 (olddata==89 ? 8'hcb :
                 (olddata==90 ? 8'hbe :
                 (olddata==91 ? 8'h39 :
                 (olddata==92 ? 8'h4a :
                 (olddata==93 ? 8'h4c :
                 (olddata==94 ? 8'h58 :
                 (olddata==95 ? 8'hcf :
                 (olddata==96 ? 8'hd0 :
                 (olddata==97 ? 8'hef :
                 (olddata==98 ? 8'haa :
                 (olddata==99 ? 8'hfb :
                 (olddata==100 ? 8'h43 :
                 (olddata==101 ? 8'h4d :
                 (olddata==102 ? 8'h33 :
                 (olddata==103 ? 8'h85 :
                 (olddata==104 ? 8'h45 :
                 (olddata==105 ? 8'hf9 :
                 (olddata==106 ? 8'h2 :
                 (olddata==107 ? 8'h7f :
                 (olddata==108 ? 8'h50 :
                 (olddata==109 ? 8'h3c :
                 (olddata==110 ? 8'h9f :
                 (olddata==111 ? 8'ha8 :
                 (olddata==112 ? 8'h51 :
                 (olddata==113 ? 8'ha3 :
                 (olddata==114 ? 8'h40 :
                 (olddata==115 ? 8'h8f :
                 (olddata==116 ? 8'h92 :
                 (olddata==117 ? 8'h9d :
                 (olddata==118 ? 8'h38 :
                 (olddata==119 ? 8'hf5 :
                 (olddata==120 ? 8'hbc :
                 (olddata==121 ? 8'hb6 :
                 (olddata==122 ? 8'hda :
                 (olddata==123 ? 8'h21 :
                 (olddata==124 ? 8'h10 :
                 (olddata==125 ? 8'hff :
                 (olddata==126 ? 8'hf3 :
                 (olddata==127 ? 8'hd2 :
                 (olddata==128 ? 8'hcd :
                 (olddata==129 ? 8'hc :
                 (olddata==130 ? 8'h13 :
                 (olddata==131 ? 8'hec :
                 (olddata==132 ? 8'h5f :
                 (olddata==133 ? 8'h97 :
                 (olddata==134 ? 8'h44 :
                 (olddata==135 ? 8'h17 :
                 (olddata==136 ? 8'hc4 :
                 (olddata==137 ? 8'ha7 :
                 (olddata==138 ? 8'h7e :
                 (olddata==139 ? 8'h3d :
                 (olddata==140 ? 8'h64 :
                 (olddata==141 ? 8'h5d :
                 (olddata==142 ? 8'h19 :
                 (olddata==143 ? 8'h73 :
                 (olddata==144 ? 8'h60 :
                 (olddata==145 ? 8'h81 :
                 (olddata==146 ? 8'h4f :
                 (olddata==147 ? 8'hdc :
                 (olddata==148 ? 8'h22 :
                 (olddata==149 ? 8'h2a :
                 (olddata==150 ? 8'h90 :
                 (olddata==151 ? 8'h88 :
                 (olddata==152 ? 8'h46 :
                 (olddata==153 ? 8'hee :
                 (olddata==154 ? 8'hb8 :
                 (olddata==155 ? 8'h14 :
                 (olddata==156 ? 8'hde :
                 (olddata==157 ? 8'h5e :
                 (olddata==158 ? 8'hb :
                 (olddata==159 ? 8'hdb :
                 (olddata==160 ? 8'he0 :
                 (olddata==161 ? 8'h32 :
                 (olddata==162 ? 8'h3a :
                 (olddata==163 ? 8'ha :
                 (olddata==164 ? 8'h49 :
                 (olddata==165 ? 8'h6 :
                 (olddata==166 ? 8'h24 :
                 (olddata==167 ? 8'h5c :
                 (olddata==168 ? 8'hc2 :
                 (olddata==169 ? 8'hd3 :
                 (olddata==170 ? 8'hac :
                 (olddata==171 ? 8'h62 :
                 (olddata==172 ? 8'h91 :
                 (olddata==173 ? 8'h95 :
                 (olddata==174 ? 8'he4 :
                 (olddata==175 ? 8'h79 :
                 (olddata==176 ? 8'he7 :
                 (olddata==177 ? 8'hc8 :
                 (olddata==178 ? 8'h37 :
                 (olddata==179 ? 8'h6d :
                 (olddata==180 ? 8'h8d :
                 (olddata==181 ? 8'hd5 :
                 (olddata==182 ? 8'h4e :
                 (olddata==183 ? 8'ha9 :
                 (olddata==184 ? 8'h6c :
                 (olddata==185 ? 8'h56 :
                 (olddata==186 ? 8'hf4 :
                 (olddata==187 ? 8'hea :
                 (olddata==188 ? 8'h65 :
                 (olddata==189 ? 8'h7a :
                 (olddata==190 ? 8'hae :
                 (olddata==191 ? 8'h8 :
                 (olddata==192 ? 8'hba :
                 (olddata==193 ? 8'h78 :
                 (olddata==194 ? 8'h25 :
                 (olddata==195 ? 8'h2e :
                 (olddata==196 ? 8'h1c :
                 (olddata==197 ? 8'ha6 :
                 (olddata==198 ? 8'hb4 :
                 (olddata==199 ? 8'hc6 :
                 (olddata==200 ? 8'he8 :
                 (olddata==201 ? 8'hdd :
                 (olddata==202 ? 8'h74 :
                 (olddata==203 ? 8'h1f :
                 (olddata==204 ? 8'h4b :
                 (olddata==205 ? 8'hbd :
                 (olddata==206 ? 8'h8b :
                 (olddata==207 ? 8'h8a :
                 (olddata==208 ? 8'h70 :
                 (olddata==209 ? 8'h3e :
                 (olddata==210 ? 8'hb5 :
                 (olddata==211 ? 8'h66 :
                 (olddata==212 ? 8'h48 :
                 (olddata==213 ? 8'h3 :
                 (olddata==214 ? 8'hf6 :
                 (olddata==215 ? 8'he :
                 (olddata==216 ? 8'h61 :
                 (olddata==217 ? 8'h35 :
                 (olddata==218 ? 8'h57 :
                 (olddata==219 ? 8'hb9 :
                 (olddata==220 ? 8'h86 :
                 (olddata==221 ? 8'hc1 :
                 (olddata==222 ? 8'h1d :
                 (olddata==223 ? 8'h9e :
                 (olddata==224 ? 8'he1 :
                 (olddata==225 ? 8'hf8 :
                 (olddata==226 ? 8'h98 :
                 (olddata==227 ? 8'h11 :
                 (olddata==228 ? 8'h69 :
                 (olddata==229 ? 8'hd9 :
                 (olddata==230 ? 8'h8e :
                 (olddata==231 ? 8'h94 :
                 (olddata==232 ? 8'h9b :
                 (olddata==233 ? 8'h1e :
                 (olddata==234 ? 8'h87 :
                 (olddata==235 ? 8'he9 :
                 (olddata==236 ? 8'hce :
                 (olddata==237 ? 8'h55 :
                 (olddata==238 ? 8'h28 :
                 (olddata==239 ? 8'hdf :
                 (olddata==240 ? 8'h8c :
                 (olddata==241 ? 8'ha1 :
                 (olddata==242 ? 8'h89 :
                 (olddata==243 ? 8'hd :
                 (olddata==244 ? 8'hbf :
                 (olddata==245 ? 8'he6 :
                 (olddata==246 ? 8'h42 :
                 (olddata==247 ? 8'h68 :
                 (olddata==248 ? 8'h41 :
                 (olddata==249 ? 8'h99 :
                 (olddata==250 ? 8'h2d :
                 (olddata==251 ? 8'hf :
                 (olddata==252 ? 8'hb0 :
                 (olddata==253 ? 8'h54 :
                 (olddata==254 ? 8'hbb : 8'h16)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));

/*	reg [7:0] index;
	reg [7:0] out;
	
	assign index = olddata;
	assign newdata = out;
//	assign newdata[7:0] = 

	always@(posedge sbytes_enable) begin
	  out<=0;
		case(index)
  		0:
		begin
			out<=8'd99;
		end
		1:
		begin
			out<=8'd124;
		end
		2:
		begin
			out<=8'd119;
		end
		3:
		begin
			out<=8'd123;
		end
		4:
		begin
			out<=8'd242;
		end
		5:
		begin
			out<=8'd107;
		end
		6:
		begin
			out<=8'd111;
		end
		7:
		begin
			out<=8'd197;
		end
		8:
		begin
			out<=8'd48;
		end
		9:
		begin
			out<=8'd1;
		end
		10:
		begin
			out<=8'd103;
		end
		11:
		begin
			out<=8'd43;
		end
		12:
		begin
			out<=8'd254;
		end
		13:
		begin
			out<=8'd215;
		end
		14:
		begin
			out<=8'd171;
		end
		15:
		begin
			out<=8'd118;
		end
		16:
		begin
			out<=8'd202;
		end
		17:
		begin
			out<=8'd130;
		end
		18:
		begin
			out<=8'd201;
		end
		19:
		begin
			out<=8'd125;
		end
		20:
		begin
			out<=8'd250;
		end
		21:
		begin
			out<=8'd89;
		end
		22:
		begin
			out<=8'd71;
		end
		23:
		begin
			out<=8'd240;
		end
		24:
		begin
			out<=8'd173;
		end
		25:
		begin
			out<=8'd212;
		end
		26:
		begin
			out<=8'd162;
		end
		27:
		begin
			out<=8'd175;
		end
		28:
		begin
			out<=8'd156;
		end
		29:
		begin
			out<=8'd164;
		end
		30:
		begin
			out<=8'd114;
		end
		31:
		begin
			out<=8'd192;
		end
		32:
		begin
			out<=8'd183;
		end
		33:
		begin
			out<=8'd253;
		end
		34:
		begin
			out<=8'd147;
		end
		35:
		begin
			out<=8'd38;
		end
		36:
		begin
			out<=8'd54;
		end
		37:
		begin
			out<=8'd63;
		end
		38:
		begin
			out<=8'd247;
		end
		39:
		begin
			out<=8'd204;
		end
		40:
		begin
			out<=8'd52;
		end
		41:
		begin
			out<=8'd165;
		end
		42:
		begin
			out<=8'd229;
		end
		43:
		begin
			out<=8'd241;
		end
		44:
		begin
			out<=8'd113;
		end
		45:
		begin
			out<=8'd216;
		end
		46:
		begin
			out<=8'd49;
		end
		47:
		begin
			out<=8'd21;
		end
		48:
		begin
			out<=8'd4;
		end
		49:
		begin
			out<=8'd199;
		end
		50:
		begin
			out<=8'd35;
		end
		51:
		begin
			out<=8'd195;
		end
		52:
		begin
			out<=8'd24;
		end
		53:
		begin
			out<=8'd150;
		end
		54:
		begin
			out<=8'd5;
		end
		55:
		begin
			out<=8'd154;
		end
		56:
		begin
			out<=8'd7;
		end
		57:
		begin
			out<=8'd18;
		end
		58:
		begin
			out<=8'd128;
		end
		59:
		begin
			out<=8'd226;
		end
		60:
		begin
			out<=8'd235;
		end
		61:
		begin
			out<=8'd39;
		end
		62:
		begin
			out<=8'd178;
		end
		63:
		begin
			out<=8'd117;
		end
		64:
		begin
			out<=8'd9;
		end
		65:
		begin
			out<=8'd131;
		end
		66:
		begin
			out<=8'd44;
		end
		67:
		begin
			out<=8'd26;
		end
		68:
		begin
			out<=8'd27;
		end
		69:
		begin
			out<=8'd110;
		end
		70:
		begin
			out<=8'd90;
		end
		71:
		begin
			out<=8'd160;
		end
		72:
		begin
			out<=8'd82;
		end
		73:
		begin
			out<=8'd59;
		end
		74:
		begin
			out<=8'd214;
		end
		75:
		begin
			out<=8'd179;
		end
		76:
		begin
			out<=8'd41;
		end
		77:
		begin
			out<=8'd227;
		end
		78:
		begin
			out<=8'd47;
		end
		79:
		begin
			out<=8'd132;
		end
		80:
		begin
			out<=8'd83;
		end
		81:
		begin
			out<=8'd209;
		end
		82:
		begin
			out<=8'd0;
		end
		83:
		begin
			out<=8'd237;
		end
		84:
		begin
			out<=8'd32;
		end
		85:
		begin
			out<=8'd252;
		end
		86:
		begin
			out<=8'd177;
		end
		87:
		begin
			out<=8'd91;
		end
		88:
		begin
			out<=8'd106;
		end
		89:
		begin
			out<=8'd203;
		end
		90:
		begin
			out<=8'd190;
		end
		91:
		begin
			out<=8'd57;
		end
		92:
		begin
			out<=8'd74;
		end
		93:
		begin
			out<=8'd76;
		end
		94:
		begin
			out<=8'd88;
		end
		95:
		begin
			out<=8'd207;
		end
		96:
		begin
			out<=8'd208;
		end
		97:
		begin
			out<=8'd239;
		end
		98:
		begin
			out<=8'd170;
		end
		99:
		begin
			out<=8'd251;
		end
		100:
		begin
			out<=8'd67;
		end
		101:
		begin
			out<=8'd77;
		end
		102:
		begin
			out<=8'd51;
		end
		103:
		begin
			out<=8'd133;
		end
		104:
		begin
			out<=8'd69;
		end
		105:
		begin
			out<=8'd249;
		end
		106:
		begin
			out<=8'd2;
		end
		107:
		begin
			out<=8'd127;
		end
		108:
		begin
			out<=8'd80;
		end
		109:
		begin
			out<=8'd60;
		end
		110:
		begin
			out<=8'd159;
		end
		111:
		begin
			out<=8'd168;
		end
		112:
		begin
			out<=8'd81;
		end
		113:
		begin
			out<=8'd163;
		end
		114:
		begin
			out<=8'd64;
		end
		115:
		begin
			out<=8'd143;
		end
		116:
		begin
			out<=8'd146;
		end
		117:
		begin
			out<=8'd157;
		end
		118:
		begin
			out<=8'd56;
		end
		119:
		begin
			out<=8'd245;
		end
		120:
		begin
			out<=8'd188;
		end
		121:
		begin
			out<=8'd182;
		end
		122:
		begin
			out<=8'd218;
		end
		123:
		begin
			out<=8'd33;
		end
		124:
		begin
			out<=8'd16;
		end
		125:
		begin
			out<=8'd255;
		end
		126:
		begin
			out<=8'd243;
		end
		127:
		begin
			out<=8'd210;
		end
		128:
		begin
			out<=8'd205;
		end
		129:
		begin
			out<=8'd12;
		end
		130:
		begin
			out<=8'd19;
		end
		131:
		begin
			out<=8'd236;
		end
		132:
		begin
			out<=8'd95;
		end
		133:
		begin
			out<=8'd151;
		end
		134:
		begin
			out<=8'd68;
		end
		135:
		begin
			out<=8'd23;
		end
		136:
		begin
			out<=8'd196;
		end
		137:
		begin
			out<=8'd167;
		end
		138:
		begin
			out<=8'd126;
		end
		139:
		begin
			out<=8'd61;
		end
		140:
		begin
			out<=8'd100;
		end
		141:
		begin
			out<=8'd93;
		end
		142:
		begin
			out<=8'd25;
		end
		143:
		begin
			out<=8'd115;
		end
		144:
		begin
			out<=8'd96;
		end
		145:
		begin
			out<=8'd129;
		end
		146:
		begin
			out<=8'd79;
		end
		147:
		begin
			out<=8'd220;
		end
		148:
		begin
			out<=8'd34;
		end
		149:
		begin
			out<=8'd42;
		end
		150:
		begin
			out<=8'd144;
		end
		151:
		begin
			out<=8'd136;
		end
		152:
		begin
			out<=8'd70;
		end
		153:
		begin
			out<=8'd238;
		end
		154:
		begin
			out<=8'd184;
		end
		155:
		begin
			out<=8'd20;
		end
		156:
		begin
			out<=8'd222;
		end
		157:
		begin
			out<=8'd94;
		end
		158:
		begin
			out<=8'd11;
		end
		159:
		begin
			out<=8'd219;
		end
		160:
		begin
			out<=8'd224;
		end
		161:
		begin
			out<=8'd50;
		end
		162:
		begin
			out<=8'd58;
		end
		163:
		begin
			out<=8'd10;
		end
		164:
		begin
			out<=8'd73;
		end
		165:
		begin
			out<=8'd6;
		end
		166:
		begin
			out<=8'd36;
		end
		167:
		begin
			out<=8'd92;
		end
		168:
		begin
			out<=8'd194;
		end
		169:
		begin
			out<=8'd211;
		end
		170:
		begin
			out<=8'd172;
		end
		171:
		begin
			out<=8'd98;
		end
		172:
		begin
			out<=8'd145;
		end
		173:
		begin
			out<=8'd149;
		end
		174:
		begin
			out<=8'd228;
		end
		175:
		begin
			out<=8'd121;
		end
		176:
		begin
			out<=8'd231;
		end
		177:
		begin
			out<=8'd200;
		end
		178:
		begin
			out<=8'd55;
		end
		179:
		begin
			out<=8'd109;
		end
		180:
		begin
			out<=8'd141;
		end
		181:
		begin
			out<=8'd213;
		end
		182:
		begin
			out<=8'd78;
		end
		183:
		begin
			out<=8'd169;
		end
		184:
		begin
			out<=8'd108;
		end
		185:
		begin
			out<=8'd86;
		end
		186:
		begin
			out<=8'd244;
		end
		187:
		begin
			out<=8'd234;
		end
		188:
		begin
			out<=8'd101;
		end
		189:
		begin
			out<=8'd122;
		end
		190:
		begin
			out<=8'd174;
		end
		191:
		begin
			out<=8'd8;
		end
		192:
		begin
			out<=8'd186;
		end
		193:
		begin
			out<=8'd120;
		end
		194:
		begin
			out<=8'd37;
		end
		195:
		begin
			out<=8'd46;
		end
		196:
		begin
			out<=8'd28;
		end
		197:
		begin
			out<=8'd166;
		end
		198:
		begin
			out<=8'd180;
		end
		199:
		begin
			out<=8'd198;
		end
		200:
		begin
			out<=8'd232;
		end
		201:
		begin
			out<=8'd221;
		end
		202:
		begin
			out<=8'd116;
		end
		203:
		begin
			out<=8'd31;
		end
		204:
		begin
			out<=8'd75;
		end
		205:
		begin
			out<=8'd189;
		end
		206:
		begin
			out<=8'd139;
		end
		207:
		begin
			out<=8'd138;
		end
		208:
		begin
			out<=8'd112;
		end
		209:
		begin
			out<=8'd62;
		end
		210:
		begin
			out<=8'd181;
		end
		211:
		begin
			out<=8'd102;
		end
		212:
		begin
			out<=8'd72;
		end
		213:
		begin
			out<=8'd3;
		end
		214:
		begin
			out<=8'd246;
		end
		215:
		begin
			out<=8'd14;
		end
		216:
		begin
			out<=8'd97;
		end
		217:
		begin
			out<=8'd53;
		end
		218:
		begin
			out<=8'd87;
		end
		219:
		begin
			out<=8'd185;
		end
		220:
		begin
			out<=8'd134;
		end
		221:
		begin
			out<=8'd193;
		end
		222:
		begin
			out<=8'd29;
		end
		223:
		begin
			out<=8'd158;
		end
		224:
		begin
			out<=8'd225;
		end
		225:
		begin
			out<=8'd248;
		end
		226:
		begin
			out<=8'd152;
		end
		227:
		begin
			out<=8'd17;
		end
		228:
		begin
			out<=8'd105;
		end
		229:
		begin
			out<=8'd217;
		end
		230:
		begin
			out<=8'd142;
		end
		231:
		begin
			out<=8'd148;
		end
		232:
		begin
			out<=8'd155;
		end
		233:
		begin
			out<=8'd30;
		end
		234:
		begin
			out<=8'd135;
		end
		235:
		begin
			out<=8'd233;
		end
		236:
		begin
			out<=8'd206;
		end
		237:
		begin
			out<=8'd85;
		end
		238:
		begin
			out<=8'd40;
		end
		239:
		begin
			out<=8'd223;
		end
		240:
		begin
			out<=8'd140;
		end
		241:
		begin
			out<=8'd161;
		end
		242:
		begin
			out<=8'd137;
		end
		243:
		begin
			out<=8'd13;
		end
		244:
		begin
			out<=8'd191;
		end
		245:
		begin
			out<=8'd230;
		end
		246:
		begin
			out<=8'd66;
		end
		247:
		begin
			out<=8'd104;
		end
		248:
		begin
			out<=8'd65;
		end
		249:
		begin
			out<=8'd153;
		end
		250:
		begin
			out<=8'd45;
		end
		251:
		begin
			out<=8'd15;
		end
		252:
		begin
			out<=8'd176;
		end
		253:
		begin
			out<=8'd84;
		end
		254:
		begin
			out<=8'd187;
		end
		255:
		begin
			out<=8'd22;
		end
    endcase
    
//    if(out != 1'b0) begin
//      sbytes_finished <= 1'b1;
//    end else begin
//      sbytes_finished <= 1'b0;
//    end*/
//  end
endmodule
