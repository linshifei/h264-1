library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.hpel_package.all;

entity hp_macroblock_buffer is
    port (  
        clock : in std_logic;
        din   : in hp_macroblock_buffer_i;
        dout  : out hp_macroblock_buffer_o
    );
end hp_macroblock_buffer;

architecture hp_macroblock_buffer of hp_macroblock_buffer is
    type pel_ram_t is array (0 to 7) of std_logic_vector(63 downto 0);
    type ref_ram_t is array (0 to 15) of std_logic_vector(79 downto 0);
    type col_ram_t is array (0 to 15) of std_logic_vector(79 downto 0);
    type row_ram_t is array (0 to 15) of std_logic_vector(71 downto 0);
    type diag_ram_t is array (0 to 15) of std_logic_vector(71 downto 0);

    signal pel_mem  : pel_ram_t;
    signal ref_mem  : ref_ram_t;
    signal col_mem  : col_ram_t;
    signal row_mem  : row_ram_t;
    signal diag_mem : diag_ram_t;

    signal pel_dout  : std_logic_vector(63 downto 0);
    signal ref_dout  : std_logic_vector(79 downto 0);
    signal col_dout  : std_logic_vector(79 downto 0);
    signal row_dout  : std_logic_vector(71 downto 0);
    signal diag_dout : std_logic_vector(71 downto 0);
begin

    dout.pel.dout  <= pel_dout;
    dout.ref.dout  <= ref_dout;
    dout.col.dout  <= col_dout;
    dout.row.dout  <= row_dout;
    dout.diag.dout <= diag_dout;

    process (clock, din.pel)
    begin
        if clock'event and clock = '1' then
            if din.pel.wren = '1' then
                pel_mem(to_integer(unsigned(din.pel.addr))) <= din.pel.din;
            end if;

            pel_dout <= pel_mem(to_integer(unsigned(din.pel.addr)));
        end if;
    end process;
        
    process (clock, din.ref)
    begin
        if clock'event and clock = '1' then
            if din.ref.wren = '1' then
                ref_mem(to_integer(unsigned(din.ref.addr))) <= din.ref.din;
            end if;

            ref_dout <= ref_mem(to_integer(unsigned(din.ref.addr)));
        end if;
    end process;

    process (clock, din.col)
    begin
        if clock'event and clock = '1' then
            if din.col.wren = '1' then
                col_mem(to_integer(unsigned(din.col.addr))) <= din.col.din;
            end if;

            col_dout <= col_mem(to_integer(unsigned(din.col.addr)));
        end if;
    end process;

    process (clock, din.row)
    begin
        if clock'event and clock = '1' then
            if din.row.wren = '1' then
                row_mem(to_integer(unsigned(din.row.addr))) <= din.row.din;
            end if;

            row_dout <= row_mem(to_integer(unsigned(din.row.addr)));
        end if;
    end process;

    process (clock, din.diag)
    begin
        if clock'event and clock = '1' then
            if din.diag.wren = '1' then
                diag_mem(to_integer(unsigned(din.diag.addr))) <= din.diag.din;
            end if;

            diag_dout <= diag_mem(to_integer(unsigned(din.diag.addr)));
        end if;
    end process;

end hp_macroblock_buffer;
