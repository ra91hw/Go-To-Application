package com.xiaoniucr.xy.utils;

import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.InjectionConfig;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.converts.MySqlTypeConvert;
import com.baomidou.mybatisplus.generator.config.po.TableInfo;
import com.baomidou.mybatisplus.generator.config.rules.DbColumnType;
import com.baomidou.mybatisplus.generator.config.rules.DbType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

public class MpGenerator {

    /**
     * Project path
     */
    private static String canonicalPath = "";

    /**
     * Package name
     */
    private static String basePackage = "Project path";

    /**
     * writer
     */
    private static String authorName = "Qianyi Liu";

    /**
     * The table prefix
     */
    private static String[] tablePrefix = {"xy_"};

    /**
     * Database type
     */
    private static DbType dbType = DbType.MYSQL;

    /**
     * Four elements of database configuration
     */
    private static String driverName;
    private static String url;
    private static String username;
    private static String password;

    /**
     * The name of the table to generate
     */
    private static String[] tables = {"xy_album_image"};

    /**
     * Customize the entity parent class
     */
    private static String superEntity = "com.xiaoniucr.xy.core.base.BaseEntity";

    /**
     * Custom entities, public fields
     */
    private static String[] superEntityColumns = {"id", "create_time","update_time"};

    /**
     * Custom controller parent class
     */
    private static String superController = "com.xiaoniucr.xy.core.base.BaseController";

    static {

        Properties properties = new Properties();
        try {
            properties.load(new FileInputStream("src/main/resources/config.properties"));
            driverName = properties.getProperty("jdbc.driver");
            url = properties.getProperty("jdbc.url");
            username = properties.getProperty("jdbc.username");
            password = properties.getProperty("jdbc.password");
        } catch (IOException e) {
            throw new RuntimeException("Data source configuration error", e);
        }
    }


    /**
     * MySQL generation demo
     */
    public static void main(String[] args) {
        AutoGenerator mpg = new AutoGenerator();

        /**
         * Get project path
         */
        try {
            canonicalPath = new File("").getCanonicalPath();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // Global configuration
        GlobalConfig gc = new GlobalConfig();
        gc.setOutputDir(canonicalPath + "/src/main/java");
        gc.setFileOverride(true);
        gc.setActiveRecord(true);
        // XML secondary cache
        gc.setEnableCache(false);
        // XML ResultMap
        gc.setBaseResultMap(true);
        // XML columList
        gc.setBaseColumnList(true);
        //Whether to open the catalog after generation
        gc.setAuthor(authorName);
        gc.setOpen(false);
        //Turn on swagger2 mode, default false
        //gc.setSwagger2(true);

        // Note that %s will automatically fill in the table entity attributes!
        // gc.setMapperName("%sDao");
        // gc.setXmlName("%sDao");
        // gc.setServiceName("MP%sService");
        // gc.setServiceImplName("%sServiceDiy");
        // gc.setControllerName("%sAction");
        mpg.setGlobalConfig(gc);

        // Data source configuration
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setDbType(dbType);
        dsc.setTypeConvert(new MySqlTypeConvert(){
            // 自定义数据库表字段类型转换【可选】
            @Override
            public DbColumnType processTypeConvert(String fieldType) {
                System.out.println("Conversion type：" + fieldType);
                //! ! ProcessTypeConvert has default type conversion. If it is not the effect you want, please customize the return, and return directly if it is not as follows.
                return super.processTypeConvert(fieldType);
            }
        });
        dsc.setDriverName(driverName);
        dsc.setUsername(username);
        dsc.setPassword(password);
        dsc.setUrl(url);
        mpg.setDataSource(dsc);

        //Package configuration
        PackageConfig pc = new PackageConfig();
        // Custom package path
        pc.setParent(basePackage);
        // pc.setModuleName("ssm");
        // pc.setMapper("mapper");
        // pc.setEntity("entity");
        // pc.setService("service");
        // pc.setServiceImpl("service.impl");
        // pc.setController("web");
        mpg.setPackageInfo(pc);

        // Policy configuration
        StrategyConfig strategy = new StrategyConfig();
        // Global uppercase naming ORACLE Note
        // strategy.setCapitalMode(true);
        /**
         * Here can be modified to your table prefix, the class file is generated to remove the prefix
         */
        strategy.setTablePrefix(tablePrefix);
        // Table name generation strategy
        strategy.setNaming(NamingStrategy.underline_to_camel);
        // Table to be generated
        strategy.setInclude(tables);
        // strategy.setExclude(new String[]{"test"}); //Table to be excluded
        // Custom entity parent class
        strategy.setSuperEntityClass(superEntity);
        // Custom entities, database public fields, will not be generated in the entity class after adding
        strategy.setSuperEntityColumns(superEntityColumns);
        // strategy.setSuperMapperClass("com.xiaoniucr.xy.core.base.BaseMapper");
        // strategy.setSuperServiceClass("com.xiaoniucr.xy.core.base.BaseService");
        // strategy.setSuperServiceImplClass("com.xiaoniucr.xy.core.base.BaseServiceImpl");
        strategy.setSuperControllerClass(superController);

        mpg.setStrategy(strategy);

/**
 * Inject custom configuration
 */
        // Inject custom configuration, you can use the value set by cfg.abc in the VM
        InjectionConfig cfg = new InjectionConfig() {
            @Override
            public void initMap() {
                Map<String, Object> map = new HashMap<String, Object>();
                map.put("abc", this.getConfig().getGlobalConfig().getAuthor() + "-mp");
                this.setMap(map);
            }
        };


        /**
         * Custom xml output location (not required)
         */
        List<FileOutConfig> fileOutList = new ArrayList<FileOutConfig>();
        fileOutList.add(new FileOutConfig("/templates/mapper.xml.vm") {
            @Override
            public String outputFile(TableInfo tableInfo) {
                return canonicalPath + "/src/main/resources/mapper/" + tableInfo.getEntityName() + "Mapper.xml";
            }
        });
        cfg.setFileOutConfigList(fileOutList);
        mpg.setCfg(cfg);

        // Turn off the default xml generation, adjust the generation to the root directory
        TemplateConfig tc = new TemplateConfig();
        tc.setXml(null);
        mpg.setTemplate(tc);

        mpg.execute();

        // print injection settings
        System.err.println(mpg.getCfg().getMap().get("abc"));
    }
}