-- Auteurs: Lenny SIEMENI, Julien KIANG
-- classe principale afficheur DCB 5 bits
-- hex0: unites, hex1: dizaines, hex2: signe + ou -
library IEEE; use IEEE.STD_LOGIC_1164.all; use IEEE.numeric_std.all;
entity Devoir_2_q2 is
	port(d: in STD_LOGIC_VECTOR(4 downto 0);
		  hex2: out STD_LOGIC_VECTOR(6 downto 0);
		  hex1: out STD_LOGIC_VECTOR(6 downto 0);
		  hex0: out STD_LOGIC_VECTOR(6 downto 0));
	end;
	architecture synth of Devoir_2_q2 is
	begin
		process(d) begin
			case d is 
				when "00000" => 
					hex0 <= "1000000"; 
					hex1 <= "1111111";
					hex2 <= "1111111"; 
				when "00001" => 
					hex0 <= "1111001";
					hex1 <= "1111111";
					hex2 <= "1111111";
				when "00010" => 
					hex0 <= "0100100";
					hex1<= "1111111";
					hex2 <= "1111111";
				when "00011" => 
					hex0 <= "0110000"; 
					hex1<= "1111111";
					hex2 <= "1111111";
				when "00100" => 
					hex0 <= "0011001"; 
					hex1<= "1111111";
					hex2 <= "1111111"; 
				when "00101" => 
					hex0 <= "0010010"; 
					hex1<= "1111111";
					hex2 <= "1111111"; 
				when "00110" => 
					hex0 <= "0000010"; 
					hex1<= "1111111";
					hex2 <= "1111111"; 
				when "00111" => 
					hex0 <= "1111000"; 
					hex1<= "1111111";
					hex2 <= "1111111"; 
				when "01000" => 
					hex0 <= "0000000"; 
					hex1<= "1111111";
					hex2 <= "1111111";
				when "01001" => 
					hex0 <= "0010000"; 
					hex1<= "1111111";
					hex2 <= "1111111";
				when "01010" => 
					hex0 <= "1000000"; 
					hex1<= "1111001";
					hex2 <= "1111111"; 
				when "01011" => 
					hex0 <= "1111001"; 
					hex1<= "1111001";
					hex2 <= "1111111";
				when "01100" => 
					hex0 <= "0100100"; 
					hex1<= "1111001";
					hex2 <= "1111111";
				when "01101" => 
					hex0 <= "0110000"; 
					hex1<= "1111001";
					hex2 <= "1111111";
				when "01110" => 
					hex0 <= "0011001"; 
					hex1<= "1111001";
					hex2 <= "1111111"; 
				when "01111" => 
					hex0 <= "0010010"; 
					hex1<= "1111001";
					hex2 <= "1111111";
				when "11111" => 
					hex0 <= "1111001"; 
					hex1<= "1111111";
					hex2 <= "0111111";
				when "11110" => 
					hex0 <= "0100100"; 
					hex1<= "1111111";
					hex2 <= "0111111";
				when "11101" =>
					hex0 <= "0110000"; 
					hex1<= "1111111";
					hex2 <= "0111111";
				when "11100" => 
					hex0 <= "0011001"; 
					hex1<= "1111111";
					hex2 <= "0111111"; 
				when "11011" => 
					hex0 <= "0010010";
					hex1<= "1111111";
					hex2 <= "0111111"; 
				when "11010" => 
					hex0 <= "0000010"; 
					hex1<= "1111111";
					hex2 <= "0111111"; 
				when "11001" => 
					hex0 <= "1111000"; 
					hex1<= "1111111";
					hex2 <= "0111111"; 
				when "11000" => 
					hex0 <= "0000000"; 
					hex1<= "1111111";
					hex2 <= "0111111";
				when "10111" => 
					hex0 <= "0010000"; 
					hex1<= "1111111";
					hex2 <= "0111111";
				when "10110" => 
					hex0 <= "1000000"; 
					hex1<= "1111001";
					hex2 <= "0111111"; 
				when "10101" => 
					hex0 <= "1111001"; 
					hex1<= "1111001";
					hex2 <= "0111111";
				when "10100" => 
					hex0 <= "0100100"; 
					hex1<= "1111001";
					hex2 <= "0111111";
				when "10011" => 
					hex0 <= "0110000"; 
					hex1<= "1111001";
					hex2 <= "0111111";
				when "10010" => 
					hex0 <= "0011001"; 
					hex1<= "1111001";
					hex2 <= "0111111"; 
				when "10001" => 
					hex0 <= "0010010"; 
					hex1<= "1111001";
					hex2 <= "0111111";
				when "10000" => 
					hex0 <= "0000010"; 
					hex1<= "1111001";
					hex2 <= "0111111";	
				when others => 
					hex0 <= "0111111";
					hex1<= "0111111";
					hex2 <= "0111111";
			end case;
		end process;
	end;	