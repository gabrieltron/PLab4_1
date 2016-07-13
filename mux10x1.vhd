library IEEE; 
use IEEE.std_logic_1164.all; 

entity mux10x1 is
	port (R0,R1,R2,R3,R4,R5,R6,R7,G,DIN: in std_logic_vector(15 downto 0);
			R0R7: in std_logic_vector(7 downto 0);
			Gout: in std_logic;
			DINout: in std_logic;
			Outp: buffer std_logic_vector(15 downto 0)
			);
end mux10x1;

architecture bhv of mux10x1 is
	begin
		Outp <= R0 when R0R7 = "00000001" and Gout = '0' and DINout = '0' else
				  R1 when R0R7 = "00000010" and Gout = '0' and DINout = '0' else
				  R2 when R0R7 = "00000100" and Gout = '0' and DINout = '0' else
				  R3 when R0R7 = "00001000" and Gout = '0' and DINout = '0' else
				  R4 when R0R7 = "00010000" and Gout = '0' and DINout = '0' else
				  R5 when R0R7 = "00100000" and Gout = '0' and DINout = '0' else
				  R6 when R0R7 = "01000000" and Gout = '0' and DINout = '0' else
				  R7 when R0R7 = "10000000" and Gout = '0' and DINout = '0' else
				  G when  R0R7 = "00000001" and Gout = '1' and DINout = '0' else
				  DIN when R0R7 = "00000001" and Gout = '0' and DINout = '1' else
				  "0000000000000000";
end bhv;
