library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.NUMERIC_STD.all;

entity testbench_ALU is
end;

architecture test of testbench_ALU is
	component alu
	port (a, b: in STD_LOGIC_VECTOR(31 downto 0);
			f: in STD_LOGIC_VECTOR (5 downto 0);
			z, o : out STD_LOGIC;
			y: out STD_LOGIC_VECTOR(31 downto 0);
			shamt: in STD_LOGIC_VECTOR(4 downto 0));
	end component;

	signal tb_shamt: STD_LOGIC_VECTOR(4 downto 0);
	signal tb_a,tb_b: STD_LOGIC_VECTOR(31 downto 0);
	signal tb_y_output: STD_LOGIC_VECTOR(31 downto 0);
	signal tb_f: STD_LOGIC_VECTOR (5 downto 0);
	signal tb_z, tb_o : STD_LOGIC;
	signal tb_clk : STD_LOGIC := '0';
	signal tb_rst_n : STD_LOGIC := '0';

	
	type SimStateType is (TSetup, State0, State1, State2, State3, State4, State5, State6, State7, State8, FinalState);
	signal SimState : SimStateType := TSetup;
	
begin
-- instantiate device to be tested
	dut:alu port map(tb_a,tb_b,tb_f,tb_z,tb_o,tb_y_output,tb_shamt);
-- Generate clock with 10 ns period
process begin
	tb_clk <= '1';
	wait for 5 ns;
	tb_clk <= '0';
	wait for 5 ns;
end process;


process(tb_clk, tb_rst_n, tb_a, tb_b, tb_f, tb_shamt)
begin
	if tb_clk = '1' and tb_clk'event then
	  case SimState is
	    When TSetup =>
	      tb_b <= X"00000001" ;
	      SimState <= State0;
	    When State0 =>          --sll fonction
	       tb_shamt <= "00001" ;
	       tb_f <= "000000";     
	    SimState <= State1;
	    When State1 =>         --add fonction
	     tb_a <= X"80000000";
	   	 tb_b <= X"7FFFFFFF";
	     tb_f <= "100000"; 
	     SimState <= State2;
	    When State2 =>         --sub fonction
	    tb_f <= "100010"; 
	     SimState <= State3;   --and fonction
	    When State3 =>
	    tb_f <= "100100"; 
	    SimState <= State4;    --or fonction
	    When State4 =>
	    tb_f <= "100101"; 
	    SimState <= State5;    --xor fonction
	    When State5 =>
	      tb_f <= "100110"; 
	      SimState <= State6;  --nor fonction
	    When State6 =>
	     tb_f <= "100111"; 
	     SimState <= State7;    --SLT signed fonction
	    When State7 =>
	    tb_f <= "101011"; 
	    SimState <= State8;     --SLTUnsigned fonction
	    When State8 => 
	      tb_f <= "101010"; 
	      SimState <= FinalState;
	    When FinalState =>
	      
	    When others =>
	   end case;
	end if;
end process;
end architecture;