--IFT1227: Devoir 4
--Auteur: Lenny SIEMENI, Matricule: 1055234
library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
	port (op: in STD_LOGIC_VECTOR (5 downto 0);
			memtoreg: out STD_LOGIC_VECTOR(1 downto 0);--modified number of bit selector for mux4 
			memwrite, branch: out STD_LOGIC;
			alusrc: out STD_LOGIC_VECTOR(1 downto 0);--modified number of bit selector for mux4
			regdst: out STD_LOGIC_VECTOR(1 downto 0);--modified number of bit selector for mux4
			regwrite, jump: out STD_LOGIC;
			jr: out STD_LOGIC;--added this to implement jr instruction
			aluop: out STD_LOGIC_VECTOR (1 downto 0));
end;

--modified the size of controls because of the use of our mux4s
architecture behave of maindec is
	signal controls: STD_LOGIC_VECTOR(12 downto 0);
begin
process(op) begin
	case op is       -- regwrite(12)|regdst(11-10)|alusrc(9-8)|branch(7)|memwrite(6)|memtoreg(5-4)|jump(3)|jr(2)|aluop(1-0)
		when "000000" => controls <= "1010000000010"; -- Rtyp
		when "100011" => controls <= "1000100010000"; -- LW
		when "101011" => controls <= "0--0101--0000"; -- SW
		when "000100" => controls <= "0--0010--0001"; -- BEQ
		when "001000" => controls <= "1000100000000"; -- ADDI
		when "000010" => controls <= "0000000001000"; -- J
		when "001100" => controls <= "111------10--"; --jal *added this*
		when "001111" => controls <= "1001000000010"; --lui *added this*
		when "001101" => controls <= "1001000000010"; --ori *added this*
		when "010001" => controls <= "10100000000--"; --IndexToAddr *added this*
		when others => controls <= "-------------"; -- illegal op
	end case;
end process;

	regwrite <= controls(12);
	regdst <= controls(11 downto 10);
	alusrc <= controls(9 downto 8);
	branch <= controls(7);
	memwrite <= controls(6);
	memtoreg <= controls(5 downto 4);
	jump <= controls(3);
	jr <= controls(2);
	aluop <= controls(1 downto 0);
end;