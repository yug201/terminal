import React, { useState } from "react";

const Terminal = () => {
  const [input, setInput] = useState("");
  const [output, setOutput] = useState([]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    if (!input.trim()) return;

    setOutput((prev) => [...prev, `$ ${input}`]);

    try {
      const res = await fetch("/backend/execute", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ command: input }),
      });

      const data = await res.json();

      if (data.error) {
        setOutput((prev) => [...prev, `Error: ${data.error}`]);
      } else {
        setOutput((prev) => [...prev, data.output]);
      }
    } catch (err) {
      setOutput((prev) => [...prev, `Error: ${err.message}`]);
    }

    setInput("");
  };

  return (
    <div className="bg-black text-white font-mono h-screen p-5">
      <div className="rounded-xl border border-gray-700 bg-gray-900 p-4 shadow-lg">
        <div className="flex items-center mb-2 space-x-2">
          <div className="w-3 h-3 bg-red-500 rounded-full"></div>
          <div className="w-3 h-3 bg-yellow-500 rounded-full"></div>
          <div className="w-3 h-3 bg-green-500 rounded-full"></div>
        </div>
        <div className="h-[70vh] overflow-y-auto mb-4">
          {output.map((line, index) => (
            <pre key={index}>{line}</pre>
          ))}
        </div>
        <form onSubmit={handleSubmit}>
          <div className="flex">
            <span className="text-green-500 mr-2">$</span>
            <input
              type="text"
              className="flex-1 bg-transparent border-none outline-none"
              value={input}
              onChange={(e) => setInput(e.target.value)}
            />
          </div>
        </form>
      </div>
    </div>
  );
};

export default Terminal;
