import asyncio
import struct
import serial_asyncio
from io import BytesIO


async def movimientoVertical(writer: asyncio.StreamWriter):
    positionY = 18
    addPosY = 1
    while 1:
        positionY = positionY + addPosY
        if positionY == 49:
            addPosY = -1

        if positionY == 7:
            addPosY = 1
        
        print(f"jugador 1 : ({5},{positionY})")
        #player2 0xEE marca
        b = struct.pack("<BBB", 0xEE, 5, positionY)
        writer.write(b)
        await asyncio.sleep(0.1)

        

async def send(writer: asyncio.StreamWriter, b: bytes) -> int:
    return await sendPacket(writer, b)

async def sendPacket(writer: asyncio.StreamWriter, packet: bytes):
    buf = BytesIO(packet)
    while 1:
        """
        data = buf.read(30)
        if not data:
            break
        """
        writer.write(buf)
        await asyncio.sleep(50 / 1000)
    return len(packet)



def listPort():
    import serial.tools.list_ports
    for i in serial.tools.list_ports.comports():
        print(i)


async def test_serial():
    
    reader, writer = await serial_asyncio.open_serial_connection(
                        url="COM9", 
                        baudrate=9600)
    
    #await writeslow(writer, struct.pack("<B", 0xEE) + b"holaidiota")
    
    asyncio.create_task(movimientoVertical(writer))
    await handle_echo(reader)

async def handle_echo(reader: asyncio.StreamReader):
    buffer = bytearray()
    while 1:
        data = await reader.read(30)
        buffer += data
        print(f"recv({len(data)})", data.hex().ljust(60), data)
        

        i = 0
        while len(buffer) > i:
            b = buffer[i]
            data = buffer[i:]

            if b == 0xdd:
                if len(data) >= 5:
                    print("Ball : ", struct.unpack("<BBBbb", data[0:5]))
                    i += 5
            if b == 0xcc:
                if len(data) >= 3:
                    print("Player Two : ", struct.unpack("<BBB", data[0:3]))
                    i += 3

            if b == 0xFA:
                print("Perdiste!")
                
            i += 1
        
        buffer = data

        """
        i = 0
        while len(buffer) > i:
            b = buffer[i]
            data = buffer[i:]
            
            if b == 0xdd:
                if len(data) >= 5:
                    print("bola : ", struct.unpack("<BBBbb", data[0:5]))
                    i += 5
            if b == 0xff:
                if len(data) >= 3:
                    print("jugador 2 : ", struct.unpack("<BBB", data[0:3]))
                    i += 3
            
            i += 1
        
        buffer = data
        """
        

        

async def main():
    listPort()
    await test_serial()

if __name__ == "__main__":
    asyncio.run(main())

