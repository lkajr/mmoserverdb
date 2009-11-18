-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.36-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema swganh
--

CREATE DATABASE IF NOT EXISTS swganh;
USE swganh;

--
-- Definition of function `sf_RemovePermissionList`
--

DROP FUNCTION IF EXISTS `sf_RemovePermissionList`;

DELIMITER $$

/*!50003 SET @TEMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ $$
CREATE DEFINER=`root`@`localhost` FUNCTION `sf_RemovePermissionList`(structure_id BIGINT(20), name CHAR(255), listname CHAR(255)) RETURNS int(11)
BEGIN
        DECLARE tmpId BIGINT(20);
        DECLARE nameId BIGINT(20);
        DECLARE ownerId BIGINT(20);

        SELECT id FROM characters WHERE STRCMP(LOWER(firstname),name)=0 INTO nameId;

        IF nameId IS NULL THEN RETURN(1);
        END IF;

        SELECT id FROM structure_admin_data WHERE (StructureId = structure_id and PlayerID = nameId and AdminType like listname) INTO tmpId;

        IF tmpId IS NULL THEN RETURN(2);
        END IF;

        SELECT owner FROM structures WHERE structures.ID = structure_id AND owner = nameId INTO ownerId;

        IF ownerId IS NOT NULL THEN RETURN(3);
        END IF;


        DELETE FROM structure_admin_data where playerId = nameId AND AdminType = listname AND StructureID = structure_id;

        RETURN(0);
END $$
/*!50003 SET SESSION SQL_MODE=@TEMP_SQL_MODE */  $$

DELIMITER ;



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
