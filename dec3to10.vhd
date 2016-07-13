LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY dec3to8 IS
  PORT ( W : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			Y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END dec3to8;

ARCHITECTURE arch OF dec3to8 IS
BEGIN
--PROCESS (W, En)
--	BEGIN
  Y <= "00000001" when W="000" else
		 "00000010" when W="001" else
		 "00000100" when W="010" else
		 "00001000" when W="011" else
		 "00010000" when W="100" else
		 "00100000" when W="101" else
		 "01000000" when W="110" else
		 "10000000" when W="111" else
		 "00000000";
  
  
 -- IF En = '1' THEN
--		CASE (W) IS
--			when "000" => Y <= "10000000";
--			when "001" => Y <= "01000000";
--			when "010" => Y <= "00100000";
--			when "011" => Y <= "00010000";
--			when "100" => Y <= "00001000";
--			when "101" => Y <= "00000100";
--			when "110" => Y <= "00000010";
--			when "111" => Y <= "00000001";
--		end case;
--		else
--			Y <= "00000000";
--end if;
--end process;
end arch;
