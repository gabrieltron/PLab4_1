LIBRARY ieee; 
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY proc IS
generic (n : integer := 16);
PORT (
		Din : in std_logic_vector(15 downto 0);
		Resetn, clk, Run, mvi_en : in std_logic;
		Done : buffer std_logic;
		BusWires : buffer std_logic_vector(15 downto 0));
END proc;

architecture Behavior OF proc IS

component regn is
	GENERIC (n : integer);
	PORT (
		R : in std_logic_vector(n-1 downto 0);
		Rin, Clock : in std_logic;
		Q : buffer std_logic_vector(n-1 downto 0)
		);
end component;

component mux10x1 is
	port (R0,R1,R2,R3,R4,R5,R6,R7,G,Din: in std_logic_vector(15 downto 0);
			R0R7: in std_logic_vector(7 downto 0);
			Gout: in std_logic;
			Dinout: in std_logic;
			Outp: buffer std_logic_vector(15 downto 0)
			);
end component;

component dec3to8 is
	port (
		W : in std_logic_vector(2 downto 0);
		Y : OUT std_logic_vector(0 TO 7)
		);
end component;

component add_sub is
	port (
		add_sub: in std_logic ;
		dataa: in std_logic_vector (15 downto 0);
		datab: in std_logic_vector (15 downto 0);
		result: OUT std_logic_vector (15 downto 0)
	);
end component;

component upcount is
	port (
		Clear, Clock : in std_logic;
		Q: out std_logic_vector(1 downto 0)
		);
end component;

component part1_control_unit is
 port(run,resetn: 	in std_logic;
		counter: 		in std_logic_vector(1 downto 0);
		IR: 				in std_logic_vector(8 downto 0);
		mvi:				in std_logic;
		R0toR7mux, R0toR7reg: out std_logic_vector(2 downto 0);
		Gout,DINout: 	out std_logic;
		Addsub,Ain: 	out std_logic;
		Gin,IRin:		out std_logic;
		clear: 			out std_logic;
		done: 			buffer std_logic
 );

end component;
 
signal Ain, AddSub, Clear, Dinout: 	std_logic;
signal Gin, Gout, IRin, Rin_en: 		std_logic;
signal Ry_en: 								std_logic;
signal sR0toR7mux, sR0toR7reg: 		std_logic_vector(2 downto 0);
signal Tstep_Q: 							std_logic_vector(1 downto 0);
signal Rin, Rout: 						std_logic_vector(7 downto 0); 
signal IR_Q: 								std_logic_vector(8 downto 0);
signal R0_Q, R1_Q, R2_Q, R3_Q: 		std_logic_vector(15 downto 0);
signal R4_Q, R5_Q, R6_Q, R7_Q: 		std_logic_vector(15 downto 0);
signal A_Q, AddSub_Q, G_Q: 			std_logic_vector(15 downto 0);

begin

Tstep: upcount port map(Clear, clk, Tstep_Q);

IR: regn	generic map (9) port map(Din(15 downto 7),IRin,clk,IR_Q);
	
decod_mux: dec3to8 port map(sR0toR7mux,Rout);
decod_reg: dec3to8 port map(sR0toR7reg,Rin);
	
R0: regn	generic map (16)	port map(BusWires,Rin(0),clk,R0_Q);
R1: regn generic map (16)	port map(BusWires,Rin(1),clk,R1_Q);
R2: regn generic map (16)	port map(BusWires,Rin(2),clk,R2_Q);
R3: regn generic map (16)	port map(BusWires,Rin(3),clk,R3_Q);
R4: regn generic map (16)	port map(BusWires,Rin(4),clk,R4_Q);
R5: regn generic map (16)	port map(BusWires,Rin(5),clk,R5_Q);
R6: regn generic map (16)	port map(BusWires,Rin(6),clk,R6_Q);
R7: regn	generic map (16)	port map(BusWires,Rin(7),clk,R7_Q);

Acc: regn generic map (16)	port map(BusWires,Ain,clk,A_Q);
	
AS: add_sub port map(AddSub,A_Q,BusWires,AddSub_Q);

G: regn	generic map (16)	port map(AddSub_Q,Gin,clk,G_Q);

mux: mux10x1 port map(R0_Q, R1_Q, R2_Q, R3_Q, R4_Q, R5_Q, R6_Q, R7_Q,G_Q,Din,
	Rout,Gout,Dinout,BusWires);

Control_unit: part1_control_unit port map(Run,Resetn,TStep_Q,IR_Q,mvi_en,sR0toR7mux,
	sR0toR7reg,Gout,Dinout,AddSub,Ain,Gin,IRin,Clear,Done);
	
END Behavior;	
--High <= '1';
--I <= IR(1 TO 3);
--decX: dec3to8 PORT MAP (IR(4 TO 6), High, Xreg);
--decY: dec3to8 PORT MAP (IR(7 TO 9), High, Yreg);

--controlsignals: process (Tstep_Q, I, Xreg, Yreg)
--begin
--... specify initial values
--CASE Tstep_Q IS
--	WHEN "00" => - - store Din in IR as long as Tstep_Q = 0
--		IRin <= '1';
--	WHEN "01" => - - define signals in time step T1
--		CASE I IS
--
--		END CASE;
--	WHEN "10" => - - define signals in time step T2
--		CASE I IS
--			...
--		END CASE;
--	WHEN "11" => - - define signals in time step T3
--		CASE I IS
--	...
--		END CASE;
--	END CASE;
--END process;
--reg_0: regn PORT MAP (BusWires, Rin(0), Clock, R0);
--.. instantiate other registers and the adder/subtracter unit
--... define the bus

