#include <string>
#include <fstream>
#include <sstream>
#include <iostream>
#include <vector>
#include "../../../thrd/json/single_include/nlohmann/json.hpp"
#include "../../../thrd/csv-parser/parser.hpp"
using json = nlohmann::json;
using namespace aria::csv;

namespace utl {
    auto jsonParser(std::string filepath){
        std::ifstream ifs(filepath);
        auto file = std::string((std::istreambuf_iterator<char>(ifs)),(std::istreambuf_iterator<char>()));
        return json::parse(file);
    }

    std::vector<std::vector<double>> fetchCSV(std::string filepath){
        std::vector<std::vector<double>> data;
        std::ifstream ifs(filepath);
        auto csvfile = CsvParser(ifs).delimiter(',');
        for (auto& row : csvfile) {
            std::vector<double> aRow;
            for (auto& field : row) {
                double value = std::atof(field.c_str());
                aRow.push_back(value);
            }
            data.push_back(aRow);
        }
        return data;
    }
}
